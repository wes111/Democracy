//
//  ToolbarNavigationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Foundation
import SwiftUI

struct ToolbarNavigationModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    let title: String?
    
    init(title: String? = nil) {
        self.title = title
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if let title {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.tertiaryText)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.tertiaryText)
                    }
                }
            }
    }
}

extension View {
    func toolbarNavigation(title: String? = nil) -> some View {
        modifier(ToolbarNavigationModifier(title: title))
    }
}
