//
//  ContentView.swift
//  Amoozesh
//
//  Created by Apple on 30/10/2024.
//

import SwiftUI

struct MainScreen: View {
    
    @State var isSplashActive = true
    
    var body: some View {
        if isSplashActive {
            SplashScreen(isActive: $isSplashActive)
        } else {
            WelcomeScreen()
        }
    }
}

#Preview {
    MainScreen()
}
