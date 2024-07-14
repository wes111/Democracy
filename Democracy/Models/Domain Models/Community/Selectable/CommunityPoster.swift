//
//  CommunityPoster.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation
import SharedResourcesClientAndServer

extension CommunityPoster: Selectable {
    
    static let metaTitle = "Allowed Posters"
    
    var title: String {
        switch self {
        case .all:
            "Anyone"
        case .leadership:
            "Community Leadership"
        case .experts:
            "Community Experts"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .all:
            "Anyone can post in the community"
        case .leadership:
            "Only community leadership can create posts"
        case .experts:
            "Only community experts can create posts"
        }
    }
    
    var image: SystemImage {
        switch self {
        case .all:
            .personThree
        case .leadership:
            .crown
        case .experts:
            .booksVerticalFill
        }
    }
}
