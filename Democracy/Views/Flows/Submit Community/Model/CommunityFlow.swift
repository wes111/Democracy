//
//  CommunityFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation

enum CommunityFlow: UserInputFlow {
    case name(CommunityNameViewModel)
    case description(CommunityDescriptionViewModel)
    case categories(CommunityCategoriesViewModel)
    case tags(CommunityTagsViewModel)
    case rules(CommunityRulesViewModel)
    case settings(CommunitySettingsViewModel)
    case resources(CommunityResourcesViewModel)
    
    enum ID: CaseIterable, Hashable {
        case name, description, categories, tags, rules, settings, resources
    }
    
    var progress: Int {
        switch self {
        case .name: 0
        case .description: 1
        case .categories: 2
        case .tags: 3
        case .rules: 4
        case .settings: 5
        case .resources: 6
        }
    }
    
    var title: String {
        switch self {
        case .name: "Community Name"
        case .description: "Community Description"
        case .categories: "Community Categories"
        case .tags: "Community Tags"
        case .rules: "Community Rules"
        case .settings: "Community Settings"
        case .resources: "Community Resources"
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
        case .resources:
            "Add Community Resources, including websites, books, and movies"
        }
    }
}
