//
//  VocabularyScreen.swift
//  Amoozesh
//
//  Created by Apple on 04/11/2024.
//

import SwiftUI

struct VocabularyScreen: View {
    @StateObject private var viewModel = VocabularyViewModel() // Observed view model
    
    let lessons: [Lesson] = loadLessonsData()
    let quizzes: [Quiz] = loadQuizData()
    
    var combinedContent: [AnyView] {
        var content: [AnyView] = []
        var quizIndex = 0
        
        for (index, lesson) in lessons.enumerated() {
            let isUnlocked = viewModel.unlockedLessons.contains(lesson.lesson) // Check if lesson is unlocked
            
            // Display LessonView with conditional opacity and disable based on lock status
            content.append(AnyView(
                LessonView(lesson: lesson)
                    .opacity(isUnlocked ? 1.0 : 0.5)
                    .disabled(!isUnlocked)
            ))
            
            // Add a quiz after every three lessons if available
            if (index + 1) % 3 == 0, quizIndex < quizzes.count {
                let quiz = quizzes[quizIndex]
                let relatedLessonNumber = (index + 1)
                let isQuizUnlocked = viewModel.unlockedQuizzes.contains(relatedLessonNumber) // Check if quiz is unlocked
                
                content.append(AnyView(
                    QuizView()
                        .opacity(isQuizUnlocked ? 1.0 : 0.5)
                        .disabled(!isQuizUnlocked)
                ))
                
                quizIndex += 1
            }
        }
        
        return content
    }
    
    var body: some View {
        List {
            ForEach(0..<combinedContent.count, id: \.self) { index in
                combinedContent[index]
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .applyToolbar(isBackVisible: true, titleBar: "Vocabulary", isSettingVisible: false)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.refreshData() // Refresh unlock status when screen appears
        }
    }
}


func loadLessonsData() -> [Lesson] {
    guard let url = Bundle.main.url(forResource: "VocabularyFlashCards", withExtension: "json") else {
        fatalError("Failed to locate VocabularyFlashCards.json in bundle.")
    }
    
    do {
        let data = try Data(contentsOf: url)
        print("Data loaded successfully") // Check if data loading is successful
        let lessonsData = try JSONDecoder().decode(LessonsData.self, from: data)
        return lessonsData.lessons
    } catch DecodingError.keyNotFound(let key, let context) {
        fatalError("Missing key '\(key.stringValue)' in JSON: \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
        fatalError("Type mismatch for type '\(type)' in JSON: \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
        fatalError("Missing value for type '\(type)' in JSON: \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(let context) {
        fatalError("Data corrupted in JSON: \(context.debugDescription)")
    } catch {
        fatalError("Failed to load or decode VocabularyFlashCards.json: \(error)")
    }
}

func loadQuizData() -> [Quiz] {
    guard let url = Bundle.main.url(forResource: "VocabQuiz", withExtension: "json") else {
        fatalError("Failed to locate VocabQuiz.json in bundle.")
    }
    
    do {
        let data = try Data(contentsOf: url)
        print("Data loaded successfully") // Check if data loading is successful
        let quizData = try JSONDecoder().decode(QuizzesData.self, from: data)
        return quizData.quizzes
    } catch DecodingError.keyNotFound(let key, let context) {
        fatalError("Missing key '\(key.stringValue)' in JSON: \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
        fatalError("Type mismatch for type '\(type)' in JSON: \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
        fatalError("Missing value for type '\(type)' in JSON: \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(let context) {
        fatalError("Data corrupted in JSON: \(context.debugDescription)")
    } catch {
        fatalError("Failed to load or decode VocabQuiz.json: \(error)")
    }
}


#Preview {
    VocabularyScreen()
}
