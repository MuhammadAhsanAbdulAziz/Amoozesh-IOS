//
//  AmoozeshApp.swift
//  Amoozesh
//
//  Created by Apple on 30/10/2024.
//

import SwiftUI

@main
struct AmoozeshApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainScreen()
                    .onAppear {
                        initializeDatabaseIfNeeded()
                    }
            }
        }
    }
    
    func initializeDatabaseIfNeeded() {
        let isDatabaseInitialized = UserDefaults.standard.bool(forKey: "isDatabaseInitialized")
        
        if !isDatabaseInitialized {
            CoreDataHelper.shared.insertInitialLessons(size: 50) // Replace with your desired number of lessons
            CoreDataHelper.shared.insertInitialQuizzes(size: 50) // Replace with your desired number of quizzes
            
            UserDefaults.standard.set(true, forKey: "isDatabaseInitialized")
        }
    }
}
