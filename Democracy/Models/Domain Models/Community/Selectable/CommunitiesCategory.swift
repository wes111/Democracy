//
//  CommunitiesCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/23/24.
//

import Foundation

// On the `CommunitiesTabMainView`, these represent the categories that
// a user can select to view a list of communities
enum CommunitiesCategory: String, Selectable {
    case isMemberOf, isLeaderOf, topCommunities, random, recommendations
    
    static let metaTitle: String = "Communities Category"
    
    var title: String {
        switch self {
        case .isMemberOf: "Member"
        case .isLeaderOf: "Leader"
        case .topCommunities: "Top"
        case .random: "Discover"
        case .recommendations: "Recommendations"
        }
    }
    
    var subtitle: String? {
        nil
    }
    
    var image: SystemImage? {
        switch self {
        case .isMemberOf: .personThree
        case .isLeaderOf: .crown
        case .topCommunities: .starFill
        case .random: .shuffle
        case .recommendations: .link
        }
    }
}
