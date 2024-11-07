//
//  WelcomeViewPager.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct onBoardingView: View {
    
    var data : onBoardingModel
    
    
    var body: some View {
        VStack (alignment:.center){
            
            Spacer()
            
            Image(data.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Text(data.name)
                .bold()
                .font(.system(size: 26))
            
            Spacer()
                .frame(height: 10)
            
            Text(data.persianName)
                .bold()
                .font(.system(size: 26))
        }
    }
}

