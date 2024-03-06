//
//  Resource.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/4/24.
//

import Foundation

struct Resource: Codable, Hashable {
    let id: String
    let title: String
    let description: String?
    let link: URL?
    let category: ResourceCategory
    let communityId: String
    
    init(
        id: String,
        title: String,
        description: String?,
        link: URL?,
        category: ResourceCategory,
        communityId: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.link = link
        self.category = category
        self.communityId = communityId
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, link, category, communityId
        
        case id = "$id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        // Link
        if let linkString = try container.decodeIfPresent(String.self, forKey: .link) {
            link = URL(string: linkString)
        } else {
            link = nil
        }
        
        category = try container.decode(ResourceCategory.self, forKey: .category)
        communityId = try container.decode(String.self, forKey: .communityId)
    }
    
    // TODO: Remove below.
    func viewModel(index: Int) -> ResourceViewModel {
        .init(
            title: title,
            description: description ?? "",
            index: index,
            url: link
        )
    }
    
    func toDTO() -> ResourceDTO {
        .init(
            title: title,
            description: description,
            link: link,
            category: category.rawValue,
            communityId: communityId
        )
    }
}

// The Resource object sent to the Appwrite database.
// Note that 'id', is not part of this object.
struct ResourceDTO: Encodable {
    let title: String
    let description: String?
    let link: URL?
    let category: String
    let communityId: String
}

// MARK: ResourceCategory Enum

enum ResourceCategory: String, Codable { // TODO: Add more categories...
    case book, website, magazine, movie
}

extension ResourceCategory: Selectable {
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
    
    var id: String {
        self.title
    }
}
