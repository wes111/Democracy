//
//  ToolbarNavigationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Foundation
import SwiftUI

enum ToolbarCenterContent: Hashable, Identifiable {
    case title(String)
    
    var id: Self {
        self
    }
}

struct ToolbarNavigationModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    let leadingButtons: [OnboardingTopButton]
    let trailingButtons: [OnboardingTopButton]
    let centerContent: ToolbarCenterContent?
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                toolbarSideContent(placement: .topBarLeading, buttons: leadingButtons)
                if let centerContent {
                    toolbarCenterContent(centerContent)
                }
                toolbarSideContent(placement: .topBarTrailing, buttons: trailingButtons)
            }
    }
}

// MARK: - Subviews
private extension ToolbarNavigationModifier {
    func toolbarCenterContent(_ content: ToolbarCenterContent) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            switch content {
            case .title(let string):
                Text(string)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
    
    func toolbarSideContent(
        placement: ToolbarItemPlacement,
        buttons: [OnboardingTopButton]
    ) -> some ToolbarContent {
        ToolbarItemGroup(placement: placement) {
            ForEach(buttons) { button in
                switch button {
                case .back:
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.tertiaryText)
                    }
                    
                case .close(let action):
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.tertiaryText)
                    }
                }
            }
        }
    }
}

// MARK: View extension
extension View {
    func toolbarNavigation(
        leadingButtons: [OnboardingTopButton] = [],
        trailingButtons: [OnboardingTopButton] = [],
        centerContent: ToolbarCenterContent? = nil
    ) -> some View {
        modifier(ToolbarNavigationModifier(
            leadingButtons: leadingButtons,
            trailingButtons: trailingButtons,
            centerContent: centerContent
        ))
    }
}
