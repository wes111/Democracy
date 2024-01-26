//
//  CreateCommunityField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityField: InputField {
    case name, description, categories, tags
    
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
        }
    }
    
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
        }
    }
    
    var required: Bool {
        switch self {
        case .name, .description, .categories, .tags:
            true
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
        }
    }
}
