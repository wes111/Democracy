//
//  CreateCommunityField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityField: InputField {
    case name, description
    
    var title: String {
        switch self {
        case .name:
            "Community Name"
        case .description:
            "Community Description"
        }
    }
    
    var subtitle: String {
        switch self {
        case .name:
            "Create a name for the new community."
        case .description:
            "Add a description to the new community."
        }
    }
    
    var fieldTitle: String {
        switch self {
        case .name:
            "Community Name"
        case .description:
            "Community Description"
        }
    }
    
    var required: Bool {
        switch self {
        case .name, .description:
            true
        }
    }
    
    var maxCharacterCount: Int {
        switch self {
        case .name:
            200
        case .description:
            2_000
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
        }
    }
    
    var alert: CreateCommunityAlert {
        switch self {
        case .name:
            .invalidName
        case .description:
            .invalidDescription
        }
    }
}
