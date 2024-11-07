//
//  CoreDataHelper.swift
//  Amoozesh
//
//  Created by Apple on 05/11/2024.
//

import CoreData
import UIKit

class CoreDataHelper {
    static let shared = CoreDataHelper()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "LessonsQuizzesModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Initial Data Insertion
    
    func insertInitialLessons(size: Int) {
        for i in 1...size {
            let lesson = VocabLesson(context: context)
            lesson.lesson_id = Int64(i)
            lesson.lesson_number = Int64(i)
            lesson.lesson_title = "Lesson \(i)"
            lesson.is_completed = false
            lesson.is_unlocked = (i == 1) // Only the first lesson is unlocked
        }
        
        saveContext()
    }
    
    func insertInitialQuizzes(size: Int) {
        for i in 1...size {
            // Determine the lesson associated with this quiz
            let lessonId = i * 3 // Each quiz is related to the third lesson in each group of 3
            let quizTitle = "Quiz \(i)"
            
            // Create a new VocabQuiz entity
            let quiz = VocabQuiz(context: context)
            quiz.quiz_id = Int64(i)
            quiz.quiz_title = quizTitle
            quiz.quiz_score = 0 // Initial score is 0
            quiz.is_unlocked = false // Initially locked

            // Fetch the lesson corresponding to lessonId
            if let associatedLesson = fetchLesson(byNumber: lessonId) {
                quiz.lesson = associatedLesson // Set the relationship
            } else {
                print("No lesson found with lesson_number \(lessonId) for quiz \(i).")
            }
        }
        
        saveContext() // Save changes to Core Data
    }
    
    func isLessonUnlocked(lessonNumber: Int) -> Bool {
        let fetchRequest: NSFetchRequest<VocabLesson> = VocabLesson.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "lesson_number == %d", lessonNumber)
        fetchRequest.fetchLimit = 1
        
        do {
            if let lesson = try context.fetch(fetchRequest).first {
                return lesson.is_unlocked // Return the lock status from Core Data
            }
        } catch {
            print("Failed to check unlock status for lesson \(lessonNumber): \(error)")
        }
        
        return false // Default to locked if not found
    }
    
    func isQuizUnlocked(lessonNumber: Int) -> Bool {
        let fetchRequest: NSFetchRequest<VocabQuiz> = VocabQuiz.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "lesson.lesson_number == %d", lessonNumber)
        fetchRequest.fetchLimit = 1
        
        do {
            if let quiz = try context.fetch(fetchRequest).first {
                return quiz.is_unlocked // Return the lock status from Core Data
            }
        } catch {
            print("Failed to check unlock status for quiz related to lesson \(lessonNumber): \(error)")
        }
        
        return false // Default to locked if not found
    }
    
    
    // Helper function to fetch a lesson by lesson number
    func fetchLesson(byNumber lessonNumber: Int) -> VocabLesson? {
        let fetchRequest: NSFetchRequest<VocabLesson> = VocabLesson.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "lesson_number == %d", lessonNumber)
        fetchRequest.fetchLimit = 1
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch lesson with number \(lessonNumber): \(error)")
            return nil
        }
    }
    
    
    func markLessonAsCompleted(lessonId: Int) {
            let fetchRequest: NSFetchRequest<VocabLesson> = VocabLesson.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "lesson_number == %d", lessonId)
            
            do {
                if let lesson = try context.fetch(fetchRequest).first {
                    lesson.is_completed = true
                    saveContext()
                }
            } catch {
                print("Failed to mark lesson as completed: \(error)")
            }
        }
    
    func unlockNextLesson(after lessonId: Int) {
            let fetchRequest: NSFetchRequest<VocabLesson> = VocabLesson.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "lesson_number > %d", lessonId)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lesson_number", ascending: true)]
            fetchRequest.fetchLimit = 1
            
            do {
                if let nextLesson = try context.fetch(fetchRequest).first {
                    nextLesson.is_unlocked = true
                    saveContext()
                }
            } catch {
                print("Failed to unlock the next lesson: \(error)")
            }
        }
    func unlockQuizIfEligible() {
            let fetchRequest: NSFetchRequest<VocabLesson> = VocabLesson.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "is_completed == true")
            
            do {
                // Get the count of completed lessons
                let completedLessonsCount = try context.count(for: fetchRequest)
                
                // Unlock the quiz if completed lessons are in multiples of 3 (3, 6, 9, etc.)
                if completedLessonsCount % 3 == 0 && completedLessonsCount > 0 {
                    // Calculate the quiz number based on completed lessons
                    let quizNumberToUnlock = completedLessonsCount / 3
                    
                    // Fetch the quiz associated with this quiz number
                    let quizFetchRequest: NSFetchRequest<VocabQuiz> = VocabQuiz.fetchRequest()
                    quizFetchRequest.fetchLimit = 1
                    quizFetchRequest.predicate = NSPredicate(format: "quiz_id == %d", quizNumberToUnlock)
                    
                    if let quiz = try context.fetch(quizFetchRequest).first {
                        quiz.is_unlocked = true
                        saveContext()
                        print("Quiz \(quizNumberToUnlock) has been unlocked.")
                    } else {
                        print("No quiz found with quiz_id \(quizNumberToUnlock).")
                    }
                }
            } catch {
                print("Failed to unlock quiz if eligible: \(error)")
            }
        }
    
    
    
    
    
    // Save context changes
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}

