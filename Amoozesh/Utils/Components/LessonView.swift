//
//  LessonView.swift
//  Amoozesh
//
//  Created by Apple on 04/11/2024.
//

import SwiftUI

struct LessonView: View {
    
    var lesson:Lesson
    
    @State var triggerNavigation  = false
    
    var body: some View {
        HStack {
            VStack {
                Text("Lesson \(lesson.lesson)")
                    .bold()
                    .font(.system(size: 20))
                
                Text(lesson.title)
                    .bold()
                    .font(.system(size: 15))
            }
            .onTapGesture {
                triggerNavigation = true
            }
            .padding() // Inner padding within the rounded rectangle
            .frame(maxWidth: .infinity)
            .background(Color.vocabLesson) // Apply the background color here
            .clipShape(RoundedRectangle(cornerRadius: 15)) // Clip to rounded shape here
        }
        .navigationDestination(isPresented: $triggerNavigation, destination: {
            VocabLessonScreen(vocabItems: lesson.vocabulary, lessonTitle: lesson.title, lessonNum: lesson.lesson)
        })
        .padding() // Outer padding for spacing
    }
}
