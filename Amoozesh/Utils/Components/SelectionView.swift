//
//  SelectionView.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct SelectionView: View {
    
    @Binding var navigateUp : Bool
    var image : String
    var name : String
    var persianName : String
    
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200,height: 200)
            
            VStack(spacing:20){
                Text(name)
                    .bold()
                    .font(.system(size: 23))
                
                Text(persianName)
                    .bold()
                    .font(.system(size: 23))
                
            }
        }
        .onTapGesture {
            navigateUp = true
        }
    }
}

