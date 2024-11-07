import SwiftUI

struct FlashcardView: View {
    let word: String
    let translation: String
    @State private var isFlipped = false
    @State private var rotationAngle = 0.0

    var body: some View {
        ZStack {
            FlashCardFrontView(word: word)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
            
            FlashCardBackView(translation: translation)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(rotationAngle + 180), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                isFlipped.toggle()
                rotationAngle += 180 // Rotate by 180 degrees
            }
        }
        .frame(width: 300, height: 400)
    }
}
