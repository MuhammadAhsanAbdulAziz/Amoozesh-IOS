//
//  ToolbarView.swift
//  Amoozesh
//
//  Created by Apple on 03/11/2024.
//

import SwiftUI

struct ToolbarModifier: ViewModifier {
    
    var isBackVisible : Bool
    var titleBar : String
    var isSettingVisible : Bool
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                
                if isBackVisible {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(titleBar)
                        .bold()
                        .font(.system(size: 20))
                }
                
                if isSettingVisible {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // Action for the trailing button
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.cyan)
                        }
                    }
                }
            }
    }
}

extension View {
    func applyToolbar(isBackVisible: Bool, titleBar: String, isSettingVisible: Bool) -> some View {
        self.modifier(ToolbarModifier(isBackVisible: isBackVisible, titleBar: titleBar, isSettingVisible: isSettingVisible))
    }
}
