//
//  CommunityCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/12/23.
//

import Foundation

struct CommunityCategory: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let imageName: String
    var postCount: Int
    
    func toCommunityCategoryViewModel() -> CommunityCategoryViewModel {
        .init(
            id: id,
            name: name,
            imageName: imageName,
            postCount: postCount
        )
    }
}
