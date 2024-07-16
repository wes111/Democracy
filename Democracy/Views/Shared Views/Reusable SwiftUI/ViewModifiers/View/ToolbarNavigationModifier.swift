//
//  ToolbarNavigationModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Foundation
import SwiftUI

struct MenuButtonOption: Identifiable {
    let title: String
    let action: @MainActor () -> Void
    
    var id: String {
        title
    }
}

enum NavigationTitleSize {
    
    case small, medium, large
}

enum TopBarContent: Identifiable {
    typealias Action = @MainActor () -> Void
    
    case title(String, size: NavigationTitleSize)
    case back(Action)
    case close(Action)
    case search(Action)
    case menu([MenuButtonOption])
    case filter(Action)

    var id: String {
        switch self {
        case .title:
            "title"
        case .back:
            "back"
        case .close:
            "close"
        case .search:
            "search"
        case .menu:
            "menu"
        case .filter:
            "filter"
        }
    }
}

@MainActor
struct ToolbarNavigationModifier: ViewModifier {
    let leadingContent: [TopBarContent]
    let centerContent: [TopBarContent]
    let trailingContent: [TopBarContent]
    
    init(
        leadingContent: [TopBarContent],
        centerContent: [TopBarContent],
        trailingContent: [TopBarContent]
    ) {
        self.leadingContent = leadingContent
        self.centerContent = centerContent
        self.trailingContent = trailingContent
        
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
                toolBarContent(content: leadingContent, placement: .topBarLeading)
                toolBarContent(content: centerContent, placement: .principal)
                toolBarContent(content: trailingContent, placement: .topBarTrailing)
            }
    }
}

// MARK: - Subviews
private extension ToolbarNavigationModifier {
    
    func toolBarContent(content: [TopBarContent], placement: ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItemGroup(placement: placement) {
            ForEach(content) { item in
                switch item {
                case .back(let action):
                    backButton(action: action)
                    
                case .title(let title, let size):
                    switch size {
                    case .small:
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primaryText)
                        
                    case .medium:
                        Text(title)
                            .primaryTitle()
                        
                    case .large:
                        Text(title)
                            .primaryTitle()
                    }
                    
                case .close(let action):
                    closeButton(action: action)
                    
                case .search(let action):
                    searchButton(action: action)
                    
                case .menu(let options):
                    menuButton(options)
                    
                case .filter(let action):
                    filterButton(action: action)
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
            Image(systemName: SystemImage.chevronLeft.rawValue)
                .foregroundColor(.tertiaryText)
        }
    }
    
    func closeButton(action: @MainActor @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.xMark.rawValue)
                .foregroundColor(.tertiaryText)
        }
    }
    
    func searchButton(action: @MainActor @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.magnifyingGlass.rawValue)
                .foregroundColor(.tertiaryText)
        }
    }
    
    func filterButton(action: @MainActor @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: SystemImage.slideVerticalThree.rawValue)
        }
    }
    
    func menuButton(_ options: [MenuButtonOption]) -> some View {
        Menu {
            ForEach(options) { option in
                Button(option.title) { option.action() }
            }
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
                .foregroundColor(.tertiaryText)
        }
    }
}

// MARK: View extension
@MainActor
extension View {
    func toolbarNavigation(
        leadingContent: [TopBarContent] = [],
        centerContent: [TopBarContent] = [],
        trailingContent: [TopBarContent] = []
    ) -> some View {
        modifier(ToolbarNavigationModifier(
            leadingContent: leadingContent,
            centerContent: centerContent,
            trailingContent: trailingContent
        ))
    }
}
