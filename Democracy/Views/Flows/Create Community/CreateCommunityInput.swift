//
//  CreateCommunityInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

// Models the user's input through the Create Community flow.
// Initially there is no user input, hence the optional and empty collection types.
final class CreateCommunityInput {
    var name: String?
    var description: String?
    var categories: Set<String>
    var tags: Set<String>
    var rules: Set<Rule>
    var settings: [String]
    var leaders: [String]
    
    init(
        name: String? = nil,
        description: String? = nil,
        categories: Set<String> = [],
        tags: Set<String> = [],
        rules: Set<Rule> = [],
        settings: [String] = [],
        leaders: [String] = []
    ) {
        self.name = name
        self.description = description
        self.categories = categories
        self.tags = tags
        self.rules = rules
        self.settings = settings
        self.leaders = leaders
    }
}
