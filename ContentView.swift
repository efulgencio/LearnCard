import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \StudySet.titulo) private var myLibrary: [StudySet]
    
    @State private var showCreateSheet = false

    var body: some View {
        NavigationStack {
            List(myLibrary) { tema in
                NavigationLink(destination: StudyView(miTemaSeleccionado: tema)) {
                    VStack(alignment: .leading) {
                        Text(tema.titulo)
                            .font(.headline)
                        Text("\(tema.tarjetas.count) tarjetas")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Mis Estudios")
            .toolbar {
                Button(action: { showCreateSheet = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showCreateSheet) {
                CreateTopicView()
            }
        }
    }
}

#Preview {
    ContentView()
}
