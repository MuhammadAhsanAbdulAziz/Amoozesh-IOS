//
//  QuizView.swift
//  Amoozesh
//
//  Created by Apple on 04/11/2024.
//

import SwiftUI

struct QuizView: View {
    
    
    var body: some View {
        HStack {
            VStack {
                Text("Quiz")
                    .bold()
                    .font(.system(size: 20))
                
                Text("Score: 0 / 15")
                    .bold()
                    .font(.system(size: 15))
            }
            .padding() // Inner padding within the rounded rectangle
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background(Color.quiz) // Apply the background color here
            .clipShape(RoundedRectangle(cornerRadius: 15)) // Clip to rounded shape here
        }
        .padding() // Outer padding for spacing
    }
}

