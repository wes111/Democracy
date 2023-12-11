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
    let topButtons: [OnboardingTopButton: () -> Void]
    
    init(title: String? = nil, topButtons: [OnboardingTopButton: () -> Void]) {
        self.title = title
        self.topButtons = topButtons
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if let title {
                    toolbarTitle(title)
                }
                
                if topButtons.keys.contains(where: { $0 == .close }) {
                    toolbarCloseButton
                }
                
                if topButtons.keys.contains(where: { $0 == .back }) {
                    toolbarBackButton
                }
            }
    }
}

// MARK: - Subviews
private extension ToolbarNavigationModifier {
    func toolbarTitle(_ title: String) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
    
    var toolbarCloseButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                if let action = topButtons[.close] {
                    action()
                } else {
                    return
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.tertiaryText)
            }
        }
    }
    
    var toolbarBackButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.tertiaryText)
            }
        }
    }
}

extension View {
    func toolbarNavigation(title: String? = nil, topButtons: [OnboardingTopButton: () -> Void]) -> some View {
        modifier(ToolbarNavigationModifier(title: title, topButtons: topButtons))
    }
}
