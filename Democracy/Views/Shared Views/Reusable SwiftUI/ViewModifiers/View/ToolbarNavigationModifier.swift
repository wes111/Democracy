//
//  ToolbarNavigationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Foundation
import SwiftUI

struct ToolbarNavigationModifier: ViewModifier {
    let title: String?
    let close: () -> Void
    
    init(title: String? = nil, close: @escaping () -> Void) {
        self.title = title
        self.close = close
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
    func toolbarNavigation(title: String? = nil, close: @escaping () -> Void) -> some View {
        modifier(ToolbarNavigationModifier(title: title, close: close))
    }
}
