//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

// SETTINGS:
// 1.) Community Government Type: Autocracy vs Democracy (Is leadership elected or self-appointed?)
// 2.) Community Visibility: Private vs public (who can view posts).
// 3.) Allows adult content.
// 4.) Which users can post? (anyone, leadership, experts/list )
// 5.) Which users can comment (members, anyone)
// 6.) Banned users
// 7.) Submitted post approval process: Requires mod approval or auto-approval

// Notes:
// 1.) A community has leaders. For the first 30? days the creator is the leader and can appoint other
//     leaders. After that time is when the voting starts?

struct TempCommunity: Codable, Hashable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
    }
}

struct Community: Hashable, Identifiable, Codable {
    let id: String // TODO: Change where id is assigned value.
    let name: String
    let summary: String
    let foundedDate: Date
    var representatives: [Candidate]
    let memberCount: Int
    var rules: [Rule]
    var resources: [Resource]
    var categories: [String]// Categories defined by community, cannot be enum.
    var tags: [String]
    var alliedCommunities: [Community]
}

struct GARBAGERule: Codable, Hashable {
    let id: String
    let title: String
    let description: String
    
    func viewModel(index: Int) -> RuleViewModel {
        .init(
            title: title,
            description: description,
            index: index
        )
    }
}

enum ResourceCategory: Codable { // TODO: Add more categories...
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

struct Resource: Codable, Hashable {
    let title: String
    let description: String?
    let url: URL?
    let category: ResourceCategory
    
    // TODO: Remove below.
    func viewModel(index: Int) -> ResourceViewModel {
        .init(
            title: title,
            description: description ?? "",
            index: index,
            url: url
        )
    }
}
