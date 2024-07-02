//
//  CommunityVisibility.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

enum CommunityVisibility: String, Codable, Selectable {
    case all, member
    
    static let metaTitle = "Community Visibility"
    
    var title: String {
        switch self {
        case .all:
            "Anyone"
        case .member:
            "Members"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .all:
            "Visible to everyone"
        case .member:
            "Visible to community members only"
        }
    }
    
    var image: SystemImage {
        switch self {
        case .all:
            .eye
        case .member:
            .eyeSlash
        }
    }
}
