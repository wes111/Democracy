//
//  ResourceCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/5/24.
//

import Foundation

enum ResourceCategory: String, Codable { // TODO: Add more categories...
    case book, website, magazine, movie
}

extension ResourceCategory: Selectable {
    var id: String {
        self.title
    }
    
    var title: String {
        switch self {
        case .book:
            "Book"
        case .website:
            "Website"
        case .magazine:
            "Magazine"
        case .movie:
            "Movie"
        }
    }
    
    var subtitle: String? {
        nil
    }
    
    var image: SystemImage {
        switch self {
        case .book:
            .bookClosed
        case .website:
            .laptopComputer
        case .magazine:
            .book
        case .movie:
            .movieClapper
        }
    }
    
    static var metaTitle: String {
        "Resource Type"
    }
}
