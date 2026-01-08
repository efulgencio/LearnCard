import SwiftUI
import SwiftData

struct CreateTopicView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var topicName: String = ""
    @State private var generatedSet: StudySet?
    @State private var isGenerating = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                Section("Generar con Pollinations AI") {
                    TextField("¿Qué quieres aprender?", text: $topicName)
                    
                    Button(isGenerating ? "Pensando..." : "Generar Preguntas") {
                        errorMessage = nil // Limpiamos errores anteriores al pulsar
                        fetchAI()
                    }
                    .disabled(topicName.isEmpty || isGenerating)
                    
                    if let error = errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }
                }

                if let set = generatedSet {
                    Section("Editar preguntas generadas") {
                        ForEach(0..<set.tarjetas.count, id: \.self) { index in
                            VStack(alignment: .leading) {
                                TextField("Pregunta", text: Binding(
                                    get: { generatedSet?.tarjetas[index].q ?? "" },
                                    set: { generatedSet?.tarjetas[index].q = $0 }
                                ))
                                .font(.headline)
                                
                                TextField("Respuesta", text: Binding(
                                    get: { generatedSet?.tarjetas[index].a ?? "" },
                                    set: { generatedSet?.tarjetas[index].a = $0 }
                                ))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    Button("Guardar en Biblioteca") {
                        modelContext.insert(set)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Nueva Sesión")
        }
    }

    func fetchAI() {
        isGenerating = true
        errorMessage = nil
        
        Task {
            let prompt = "Genera un cuestionario JSON de 2 preguntas sobre \(topicName). Estructura: {\"titulo\": \"\", \"preguntas\": [{\"q\": \"\", \"a\": \"\"}]}"
            
            guard let encoded = prompt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "https://text.pollinations.ai/\(encoded)?json=true&model=mistral") else {
                isGenerating = false
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let dto = try JSONDecoder().decode(StudySetDTO.self, from: data)
                
                let finalSet = StudySet(
                    titulo: dto.titulo,
                    tarjetas: dto.preguntas.map { Flashcard(q: $0.q, a: $0.a) }
                )
                
                await MainActor.run {
                    self.generatedSet = finalSet
                    self.isGenerating = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Error de conexión. Intenta con un tema más simple."
                    self.isGenerating = false
                }
            }
        }
    }
}
