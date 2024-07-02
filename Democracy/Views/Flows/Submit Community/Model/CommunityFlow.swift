//
//  CommunityFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation

enum CommunityFlow: UserInputFlow {
    case name(CommunityNameViewModel)
    case tagline(CommunityTaglineViewModel)
    case description(CommunityDescriptionViewModel)
    case categories(CommunityCategoriesViewModel)
    case tags(CommunityTagsViewModel)
    case rules(CommunityRulesViewModel)
    case settings(CommunitySettingsViewModel)
    case resources(CommunityResourcesViewModel)
    
    // swiftlint:disable:next all
    enum ID: CaseIterable, Hashable, Equatable {
        case name, description, categories, tags, tagline, rules, settings, resources
    }
    
    var id: ID {
        switch self {
        case .name: .name
        case .tagline: .tagline
        case .description: .description
        case .categories: .categories
        case .tags: .tags
        case .rules: .rules
        case .settings: .settings
        case .resources: .resources
        }
    }
    
    var progress: Int {
        switch self {
        case .name: 0
        case .tagline: 1
        case .description: 2
        case .categories: 3
        case .tags: 4
        case .rules: 5
        case .settings: 6
        case .resources: 7
        }
    }
    
    var title: String {
        switch self {
        case .name: "Community Name"
        case .tagline: "Community Tagline"
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
        case .tagline:
            "Add a tagline for users to get a quick overview of the community's main topic."
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
