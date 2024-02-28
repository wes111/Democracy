//
//  CreateCommunityAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityAlert: AlertModelProtocol {
    case missingCategory, categoryAlreadyAdded, missingTag, tagAlreadyAdded, missingRule, ruleAlreadyAdded,
         unableToEditResource, unableToEditRule
    
    var title: String {
        switch self {
        case .missingCategory:
            "Missing Category"
        case .categoryAlreadyAdded:
            "Category Already Added"
        case .missingTag:
            "Missing Tag"
        case .tagAlreadyAdded:
            "Tag Already Added"
        case .missingRule:
            "Missing Rule"
        case .ruleAlreadyAdded:
            "Rule Already Added"
        case .unableToEditResource:
            "Resource Unavailable"
        case .unableToEditRule:
            "Rule Unavailable"
        }
    }
    
    var description: String {
        switch self {
        case .missingCategory:
            "Communities must have at least 1 category."
        case .categoryAlreadyAdded:
            "This category has already been added."
        case .missingTag:
            "Communities must have at least 1 tag."
        case .tagAlreadyAdded:
            "This tag has already been added."
        case .missingRule:
            "Communities must have at least 1 rule."
        case .ruleAlreadyAdded:
            "This rule has already been added."
        case .unableToEditResource:
            "The resource is not available to edit."
        case .unableToEditRule:
            "The rule is not available to edit."
        }
    }
}
