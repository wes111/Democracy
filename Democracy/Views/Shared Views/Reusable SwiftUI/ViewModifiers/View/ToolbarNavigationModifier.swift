//
//  ToolbarNavigationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Foundation
import SwiftUI

struct ToolbarNavigationModifier: ViewModifier {
    let title: String
    let close: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.tertiaryText)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        close()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.tertiaryText)
                    }
                }
            }
    }
}

extension View {
    func toolbarNavigation(title: String, close: @escaping () -> Void) -> some View {
        modifier(ToolbarNavigationModifier(title: title, close: close))
    }
}
