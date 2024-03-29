//
//  CommunityContent.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

enum CommunityContent: String, Codable, Selectable {
    
    case familyFriendly, adultContent
    
    static let metaTitle = "Content Type"
    
    var title: String {
        switch self {
        case .familyFriendly:
            "Family Friendly"
        case .adultContent:
            "Adult Content Allowed"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .familyFriendly:
            "Adult content is not allowed within the community."
        case .adultContent:
            "Members and visitors must be 18+ and can post adult content."
        }
    }
    
    var image: SystemImage {
        switch self {
        case .familyFriendly:
            .figureAndChildHoldingHands
        case .adultContent:
            .exclamationmarkTriangle
        }
    }
}
