//
//  FlashCardView.swift
//  Amoozesh
//
//  Created by Apple on 07/11/2024.
//

import SwiftUI

struct FlashCardBackView: View {
    
    var translation : String
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(translation)
                .foregroundStyle(.black)
                .font(.system(size: 40))
                .bold()
            
            Spacer()
            
        }
        .frame(width:300,height: 400)
        .background(.vocabLesson)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
    }
}

#Preview {
    FlashCardBackView(translation: "Hello")
}
