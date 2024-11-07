//
//  HomeScreen.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var navigateToClassesScreen = false
    
    var body: some View {
        VStack(alignment:.center){
            
            SelectionView(navigateUp: $navigateToClassesScreen, image: "classes_img", name: "Classes", persianName: "صنف های درسی")
            
            Spacer()
            
            SelectionView(navigateUp: $navigateToClassesScreen, image: "discussion_img", name: "Discussion Board", persianName: "هیئت گفتگو")
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToClassesScreen, destination: {
            ClassesScreen()
        })
        .applyToolbar(isBackVisible: false, titleBar: "Amoozesh", isSettingVisible: true)
    }
    
}

#Preview {
    HomeScreen()
}
