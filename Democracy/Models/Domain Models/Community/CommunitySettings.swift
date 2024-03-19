//
//  CommunitySettings.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

struct CommunitySettings {
    var government: CommunityGovernment
    var content: CommunityContent
    var visibility: CommunityVisibility
    var poster: CommunityPoster
    var commenter: CommunityCommenter
    var postApproval: CommunityPostApproval
    
    init(
        government: CommunityGovernment = .autocracy,
        content: CommunityContent = .familyFriendly,
        visibility: CommunityVisibility = .member,
        poster: CommunityPoster = .all,
        commenter: CommunityCommenter = .all,
        postApproval: CommunityPostApproval = .automatic
    ) {
        self.government = government
        self.content = content
        self.visibility = visibility
        self.poster = poster
        self.commenter = commenter
        self.postApproval = postApproval
    }
}

enum CommunitySetting: Identifiable {
    case governmentType, allowsAdultContent, visibility, poster, commenter, postApproval
    
    var id: Int {
        switch self {
        case .governmentType: 1
        case .allowsAdultContent: 2
        case .visibility: 3
        case .poster: 4
        case .commenter: 5
        case .postApproval: 6
        }
    }
}

