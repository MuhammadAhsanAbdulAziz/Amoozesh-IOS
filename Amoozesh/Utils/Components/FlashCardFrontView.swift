//
//  FlashCardView.swift
//  Amoozesh
//
//  Created by Apple on 07/11/2024.
//

import SwiftUI

struct FlashCardFrontView: View {
    
    var word : String
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(word)
                .foregroundStyle(.black)
                .font(.system(size: 40))
                .bold()
            
            Spacer()
            
            HStack{
                Image(systemName:"document.on.document")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25,height: 25)
                Image(systemName:"speaker.wave.2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25,height: 25)
                
                Spacer()
            }
            .padding()
        }
        .frame(width:300,height: 400)
        .background(.vocabLesson)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
    }
}

#Preview {
    FlashCardFrontView(word: "Hello")
}
