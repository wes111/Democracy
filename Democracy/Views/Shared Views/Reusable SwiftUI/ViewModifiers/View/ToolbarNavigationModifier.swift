//
//  ToolbarNavigationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Foundation
import SwiftUI

enum ToolBarLeadingContent: Identifiable {
    typealias Action = @MainActor () -> Void
    
    case title(String)
    case back(Action)
    
    var name: String {
        switch self {
        case .title:
            "title"
        case .back:
            "back"
        }
    }
    
    var id: String {
        name
    }
}

@MainActor
struct ToolbarNavigationModifier: ViewModifier {
    let leadingButtons: [ToolBarLeadingContent]
    let trailingButtons: [OnboardingTopButton]
    
    init(
        leadingButtons: [ToolBarLeadingContent],
        trailingButtons: [OnboardingTopButton]
    ) {
        self.leadingButtons = leadingButtons
        self.trailingButtons = trailingButtons
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(.primaryText)
        ]
        navigationBarAppearance.backgroundColor = UIColor(.primaryBackground)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().clipsToBounds = true
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = UIColor(.primaryBackground)
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                toolbarLeadingContent(content: leadingButtons)
                toolbarTrailingContent(buttons: trailingButtons)
            }
    }
}

// MARK: - Subviews
private extension ToolbarNavigationModifier {
    
    func toolbarLeadingContent(content: [ToolBarLeadingContent]) -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            ForEach(content) { item in
                switch item {
                case .back(let action):
                    backButton(action: action)
                    
                case .title(let title):
                    Text(title)
                        .primaryTitle()
                }
            }
        }
    }
    
    func toolbarTrailingContent(buttons: [OnboardingTopButton]) -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            ForEach(buttons) { button in
                switch button {
                case .back(let action):
                    backButton(action: action)
                    
                case .close(let action):
                    closeButton(action: action)
                    
                case .search(let action):
                    searchButton(action: action)
                    
                case .menu(let options):
                    menuButton(options)
                }
            }
        }
    }
}

// MARK: Buttons
private extension ToolbarNavigationModifier {
    func backButton(action: @MainActor @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.tertiaryText)
        }
    }
    
    func closeButton(action: @MainActor @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.tertiaryText)
        }
    }
    
    func searchButton(action: @MainActor @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.tertiaryText)
        }
    }
    
    func menuButton(_ options: [MenuButtonOption]) -> some View {
        Menu {
            ForEach(options) { option in
                Button(option.title) { option.action() }
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.tertiaryText)
        }
    }
}

// MARK: View extension
@MainActor
extension View {
    func toolbarNavigation(
        leadingButtons: [ToolBarLeadingContent] = [],
        trailingButtons: [OnboardingTopButton] = []
    ) -> some View {
        modifier(ToolbarNavigationModifier(
            leadingButtons: leadingButtons,
            trailingButtons: trailingButtons
        ))
    }
}
