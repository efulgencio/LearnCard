import SwiftUI

struct FlipCardView: View {
    let card: Flashcard
    @State private var flipped = false
    
    var body: some View {
        ZStack {
            CardFace(text: card.a, color: .green)
                .rotation3DEffect(.degrees(flipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                .opacity(flipped ? 1 : 0)
            
            CardFace(text: card.q, color: .blue)
                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(flipped ? 0 : 1)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                flipped.toggle()
            }
        }
        .frame(height: 300)
        .padding()
    }
}

struct CardFace: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 20).fill(color.opacity(0.1)))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 2))
    }
}
