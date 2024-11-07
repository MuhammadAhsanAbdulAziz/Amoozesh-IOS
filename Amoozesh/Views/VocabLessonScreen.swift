import SwiftUI

struct VocabLessonScreen: View {
    let vocabItems: [VocabularyItem]
    let lessonTitle: String
    let lessonNum: Int
    
    @State private var showCompletionAlert = false // State variable to show alert
    @Environment(\.presentationMode) var presentationMode
    @State private var currentIndex = 0 // Track the current word index
    
    var body: some View {
        VStack {
            if currentIndex <= vocabItems.count {
                // Show the flashcard with the current word and translation
                FlashcardView(word: vocabItems[currentIndex].word,
                              translation: vocabItems[currentIndex].translation)
                
                Spacer()
                
                // Next button to progress to the next flashcard
                Button(action: {
                    withAnimation {
                        if currentIndex < vocabItems.count - 1 {
                            currentIndex += 1
                        }
                        else{
                            showCompletionAlert = true
                        }
                    }
                }) {
                    if currentIndex < vocabItems.count - 1 {
                        HStack{
                            Text("NEXT CARD")
                            
                            Image(systemName: "arrow.forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20,height: 20)
                        }
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
                    }
                    else{
                        HStack{
                            Text("FINISH")
                            
                        }
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
                    }
                    
                }
                
            }
        }
        .alert(isPresented: $showCompletionAlert) {
            Alert(
                title: Text("Lesson Completed"),
                message: Text("You have successfully completed this lesson!"),
                dismissButton: .default(Text("OK")) {
                    CoreDataHelper.shared.markLessonAsCompleted(lessonId: lessonNum)
                    if lessonNum % 3 != 0 {
                        CoreDataHelper.shared.unlockNextLesson(after: lessonNum)
                    }
                    CoreDataHelper.shared.unlockQuizIfEligible()
                    
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationBarBackButtonHidden(true)
        .applyToolbar(isBackVisible: true, titleBar: lessonTitle, isSettingVisible: false)
        .padding()
    }
}
