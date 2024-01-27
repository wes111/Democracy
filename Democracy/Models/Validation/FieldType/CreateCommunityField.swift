//
//  CreateCommunityField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityField: InputField {
    case name, description, categories, tags, ruleTitle, ruleDescription
    
    var fieldTitle: String {
        switch self {
        case .name:
            "Community Name"
        case .description:
            "Community Description"
        case .categories:
            "Community Categories"
        case .tags:
            "Community Tags"
        case .ruleTitle:
            "Rule Title"
        case .ruleDescription:
            "Rule Description"
        }
    }
    
    var maxCharacterCount: Int {
        switch self {
        case .name:
            200
        case .description:
            2_000
        case .categories:
            100
        case .tags:
            25 // TODO: ... ???
        case .ruleTitle:
            100
        case .ruleDescription:
            200
        }
    }
    
    var fullRegex: String {
        switch self {
            /// Checks if the string is between 1 and 200 characters in length.
        case .name:
            "^.{1,200}$"
            
            /// Checks if the string is between 1 and 1000 characters in length.
        case .description:
            "^.{1,1000}$"
            
            /// Checks if the string is between 1 and 200 characters in length.
        case .categories:
            "^.{1,200}$"
            
            /// Checks if the string is between 1 and 25 characters in length.
        case .tags:
            "^.{1,25}$"
            
            /// Checks if the string is between 1 and 100 characters in length.
        case .ruleTitle:
            "^.{1,100}$"
            
            /// Checks if the string is between 1 and 200 characters in length.
        case .ruleDescription:
            "^.{1,200}$"
        }
    }
    
    var alert: CreateCommunityAlert {
        switch self {
        case .name:
            .invalidName
        case .description:
            .invalidDescription
        case .categories:
            .invalidCategory
        case .tags:
            .invalidTag
        case .ruleTitle:
            .invalidRuleTitle
        case .ruleDescription:
            .invalidRuleDescription
        }
    }
}
