//
//  OnboardingTopButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

enum OnboardingTopButton: Identifiable {
    typealias Action = () -> Void
    
    case back
    case close(Action)
    
    var id: String {
        switch self {
        case .back:
            "back"
        case .close:
            "close"
        }
    }
}
