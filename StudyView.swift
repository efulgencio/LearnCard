import SwiftUI

struct StudyView: View {
    let miTemaSeleccionado: StudySet
    
    var body: some View {
        VStack {
            Text(miTemaSeleccionado.titulo)
                .font(.largeTitle)
                .bold()
                .padding(.top)

            TabView {
                ForEach(miTemaSeleccionado.tarjetas) { tarjeta in
                    FlipCardView(card: tarjeta)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Spacer()
            
            Text("Desliza para ver más preguntas")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
        .navigationTitle("Repaso")
        .navigationBarTitleDisplayMode(.inline)
    }
}
