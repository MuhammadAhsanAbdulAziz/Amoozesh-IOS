//
//  VocabModel.swift
//  Amoozesh
//
//  Created by Apple on 04/11/2024.
//

import Foundation

struct LessonsData: Codable {
    let lessons: [Lesson]
}

struct Lesson: Codable, Identifiable {
    var id = UUID() // Unique identifier for SwiftUI
    let lesson: Int
    let title: String
    let vocabulary: [VocabularyItem]
    
    // Specify CodingKeys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case lesson, title, vocabulary
    }
}

struct VocabularyItem: Codable, Identifiable {
    var id = UUID() // Unique identifier for SwiftUI
    let word: String
    let translation: String
    
    // Specify CodingKeys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case word, translation
    }
}

