//
//  VocabQuizModel.swift
//  Amoozesh
//
//  Created by Apple on 04/11/2024.
//

import Foundation

// Top-level structure for the JSON data
struct QuizzesData: Codable {
    let quizzes: [Quiz]
}

// Each Quiz contains multiple questions
struct Quiz: Codable, Identifiable {
    var id = UUID() // Unique identifier for SwiftUI
    let quiz: [Question]

    // Specify CodingKeys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case quiz
    }
}

// Each Question contains the question text, an array of answers, and the correct answer
struct Question: Codable, Identifiable {
    var id = UUID() // Unique identifier for SwiftUI
    let question: String
    let answers: [String]
    let correctAnswer: String

    // Specify CodingKeys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case question, answers, correctAnswer
    }
}

