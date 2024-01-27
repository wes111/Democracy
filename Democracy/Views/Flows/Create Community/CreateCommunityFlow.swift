//
//  CreateCommunityFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityFlow: Int, UserInputFlow {
    case name = 0
    case description = 1
    case categories = 2
    case tags = 3
    case rules = 4
    case settings = 5
    case leaders = 6
    
    var title: String {
        switch self {
        case .name:
            "Community Name"
        case .description:
            "Community Description"
        case .categories:
            "Community Categories"
        case .tags:
            "Community Tags"
        case .rules:
            "Community Rules"
        case .settings:
            "Community Settings"
        case .leaders:
            "Community Leaders"
        }
    }
    
    var subtitle: String {
        switch self {
        case .name:
            "Create a name for the new community."
        case .description:
            "Add a description to the new community."
        case .categories:
            "Add at least one category to the community. Categories are used to organize posts. More categories can be added later."
        case .tags:
            "Add tags to improve searchability of posts within the community."
        case .rules:
            "Add rules to the community that must be followed by all users."
        case .settings:
            "Choose the initial community settings. These can be updated later."
        case .leaders:
            "Choose the initial community leaders. These can be updated later."
        }
    }
    
    var required: Bool {
        switch self {
        case .name, .description, .categories, .tags, .rules, .settings, .leaders:
            true
        }
    }
}
