//
//  AlliedCommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import Foundation

struct AlliedCommunityViewModel: Identifiable {
    
    let community: Community
    let id = UUID().uuidString
    let title: String
    
    init(_ community: Community) {
        self.community = community
        self.title = community.name
    }
}
