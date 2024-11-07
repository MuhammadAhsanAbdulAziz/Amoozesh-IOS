//
//  ClassesScreen.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct ClassesScreen: View {
    
    @State var navigateToVocab = false
    @State var navigateToGrammar = false
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                
                Text("Classes")
                    .bold()
                    .font(.system(size: 26))
                    .padding()
                
                SelectionView(navigateUp: $navigateToVocab, image: "one", name: "Vocabulary", persianName: "لغات")
                    .onTapGesture {
                        navigateToVocab = true
                    }
                
                SelectionView(navigateUp: $navigateToVocab, image: "two", name: "Grammar", persianName: "دستور زبان")
                
                SelectionView(navigateUp: $navigateToVocab, image: "three", name: "Communication", persianName: "مکالمه")
                
                SelectionView(navigateUp: $navigateToVocab, image: "four", name: "Books", persianName: "کتاب ها")
                
                
                
            }
            .applyToolbar(isBackVisible: true, titleBar: "Amoozesh", isSettingVisible: true)
            .navigationDestination(isPresented: $navigateToVocab, destination: {
                VocabularyScreen()
            })
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

#Preview {
    ClassesScreen()
}
