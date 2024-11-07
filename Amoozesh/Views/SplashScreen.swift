//
//  SplashScreen.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var scale = 0.7
    @Binding var isActive : Bool
    
    var body: some View {
        VStack(alignment:.center){
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200,height: 200)
            
            Text("Amoozesh")
                .bold()
                .font(.system(size: 20))
        }.scaleEffect(scale)
            .onAppear{
                withAnimation(.easeIn(duration: 0.7)) {
                    self.scale = 0.9
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = false
                    }
                }
            }
    }
}

