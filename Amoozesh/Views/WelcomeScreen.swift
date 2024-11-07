//
//  WelcomeScreen.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var currentScreen = 0
    private var screens = onBoardingData.onBoardingScreens
    @State private var navigateToNextScreen = false
    
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        VStack{
            
            TabView(selection: $currentScreen) {
                ForEach(0..<screens.count, id: \.self) { it in
                    onBoardingView(data: screens[it] )
                        .tag(it)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()
                .frame(height: 30)
            
            HStack{
                ForEach(0..<screens.count, id: \.self) { it in
                    if it == currentScreen {
                        Rectangle()
                            .frame(width: 20,height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(.yellow)
                    } else {
                        Circle()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            CustomButton(text: currentScreen < screens.count - 1 ? "Next" : "Get Started", color: .gray, textColor: .white, isLoading: false) {
                if currentScreen < screens.count - 1 {
                    withAnimation {
                        currentScreen += 1
                    }
                } else{
                    navigateToNextScreen = true
                }
            }
        }
        .navigationDestination(isPresented: $navigateToNextScreen) {
            HomeScreen()
        }
        
    }
}

#Preview {
    WelcomeScreen()
}
