//
//  VocabularyViewModel.swift
//  Amoozesh
//
//  Created by Apple on 07/11/2024.
//

import SwiftUI
import CoreData


class VocabularyViewModel: ObservableObject {
    @Published var unlockedLessons: [Int] = [] // Store only the lesson numbers that are unlocked
    @Published var unlockedQuizzes: [Int] = [] // Store only the lesson numbers associated with unlocked quizzes
    
    init() {
        loadUnlockStatus()
    }
    
    func loadUnlockStatus() {
        // Fetch all unlocked lessons from Core Data
        unlockedLessons = fetchUnlockedLessons()
        
        // Fetch all unlocked quizzes based on lesson numbers
        unlockedQuizzes = fetchUnlockedQuizzes()
    }
    
    func fetchUnlockedLessons() -> [Int] {
        let fetchRequest: NSFetchRequest<VocabLesson> = VocabLesson.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "is_unlocked == true")
        
        do {
            let unlockedLessons = try CoreDataHelper.shared.context.fetch(fetchRequest)
            return unlockedLessons.map { Int($0.lesson_number) } // Return unlocked lesson numbers
        } catch {
            print("Failed to fetch unlocked lessons: \(error)")
            return []
        }
    }
    
    func fetchUnlockedQuizzes() -> [Int] {
        let fetchRequest: NSFetchRequest<VocabQuiz> = VocabQuiz.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "is_unlocked == true")
        
        do {
            let unlockedQuizzes = try CoreDataHelper.shared.context.fetch(fetchRequest)
            return unlockedQuizzes.compactMap { Int($0.lesson?.lesson_number ?? 0) }
        } catch {
            print("Failed to fetch unlocked quizzes: \(error)")
            return []
        }
    }
    
    func refreshData() {
        loadUnlockStatus() // Reloads unlock status whenever needed
    }
}

