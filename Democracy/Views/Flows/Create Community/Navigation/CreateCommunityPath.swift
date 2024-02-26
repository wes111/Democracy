//
//  CreateCommunityPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityPath: Hashable {
    case goToCommunityDescription(CommunityDescriptionViewModel)
    case goToCommunityCategories(CommunityCategoriesViewModel)
    case goToCommunityTags(CommunityTagsViewModel)
    case goToCommunityRules(CommunityRulesViewModel)
    case goToCommunitySettings(CommunitySettingsViewModel)
    case goToCommunityResources(CommunityResourcesViewModel)
    case goToCommunitySuccess(CreateCommunitySuccessViewModel)
}
