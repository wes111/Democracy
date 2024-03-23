//
//  OnboardingTopButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
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

enum OnboardingTopButton: Identifiable {
    typealias Action = @MainActor () -> Void
    
    case back(Action)
    case close(Action)
    case search(Action)
    case menu([MenuButtonOption])
    
    var name: String {
        switch self {
        case .back:
            "back"
        case .close:
            "close"
        case .search:
            "search"
        case .menu:
            "menu"
        }
    }
    
    var id: String {
        name
    }
}
