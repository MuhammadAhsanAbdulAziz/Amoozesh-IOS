//
//  CustomButton.swift
//  ChatGeniusAI
//
//  Created by Apple on 30/10/2024.
//

import SwiftUI

struct CustomButton: View {
    
    var text : String
    var color : UIColor
    var textColor : UIColor
    var isLoading : Bool
    var onClick : ()-> Void
    
    var body: some View {
        Button{
            onClick()
        } label:{
            ZStack{
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                else {
                    Text(text)
                        .foregroundStyle(Color(textColor))
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20,weight: .semibold))
                }
            }
            .frame(maxWidth: 160,minHeight: 65)
            .background(Color(color))
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

