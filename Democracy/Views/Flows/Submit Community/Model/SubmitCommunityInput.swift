//
//  CreateCommunityInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation
import SharedResourcesClientAndServer

// Models the user's input through the Create Community flow.
// Initially there is no user input, hence the optional and empty collection types.
final class SubmitCommunityInput {
    var name: String?
    var description: String?
    var categories: [PostCategoryCreationRequest]
    var tags: Set<String>
    var tagline: String?
    var rules: Set<Rule>
    var settings: CommunitySettingsCreationRequest
    var resources: [Resource]
    
    init(
        name: String? = nil,
        description: String? = nil,
        categories: [PostCategoryCreationRequest] = [],
        tags: Set<String> = [],
        tagline: String? = nil,
        rules: Set<Rule> = [],
        settings: CommunitySettingsCreationRequest = CommunitySettings().toCreationRequest(),
        resources: [Resource] = []
    ) {
        self.name = name
        self.description = description
        self.categories = categories
        self.tags = tags
        self.tagline = tagline
        self.rules = rules
        self.settings = settings
        self.resources = resources
    }
}
