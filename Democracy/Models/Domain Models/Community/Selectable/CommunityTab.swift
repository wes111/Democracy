//
//  CommunityTab.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/25/24.
//

import Foundation

enum CommunityTab: String, Selectable {
    case feed, info, archive
    
    static let metaTitle: String = "Community Tab"
    static let metaImage: SystemImage = .book
    
    var title: String {
        switch self {
        case .feed: "Feed"
        case .info: "Info"
        case .archive: "Archive"
        }
    }
    
    var subtitle: String? {
        nil
    }
    
    var image: SystemImage? {
        switch self {
        case .feed:
                .newspaperFill
        case .info:
                .infoCircle
        case .archive:
                .booksVerticalFill
        }
    }
}
