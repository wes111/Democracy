//
//  CommunityPostApproval.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

enum CommunityPostApproval: Selectable {
    case automatic, mod
    
    static let metaTitle = "Post Approval Process"
    
    var title: String {
        switch self {
        case .automatic:
            "Automatic"
        case .mod:
            "Mod Approval"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .automatic:
            "Posts are approved automatically"
        case .mod:
            "Posts are approved by Community mods"
        }
    }
    
    var image: SystemImage {
        switch self {
        case .automatic:
            .bolt
        case .mod:
            .checkmark
        }
    }
}
