//
//  CreateCommunityAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityAlert: AlertModelProtocol {
    case invalidName, invalidDescription, invalidCategory, missingCategory, categoryAlreadyAdded,
         invalidTag, missingTag, tagAlreadyAdded, missingRule, ruleAlreadyAdded, invalidRuleTitle,
         invalidRuleDescription
    
    var title: String {
        switch self {
        case .invalidName:
            "Invalid Name"
        case .invalidDescription:
            "Invalid Description"
        case .invalidCategory:
            "Invalid Category"
        case .missingCategory:
            "Missing Category"
        case .categoryAlreadyAdded:
            "Category Already Added"
        case .invalidTag:
            "Invalid Tag"
        case .missingTag:
            "Missing Tag"
        case .tagAlreadyAdded:
            "Tag Already Added"
        case .missingRule:
            "Missing Rule"
        case .ruleAlreadyAdded:
            "Rule Already Added"
        case .invalidRuleTitle:
            "Invalid Rule Title"
        case .invalidRuleDescription:
            "Invalid Rule Description"
        }
    }
    
    var description: String {
        switch self {
        case .invalidName:
            "This name is already in use. Please enter a new name."
        case .invalidDescription:
            "Please enter a description that matches the requirements."
        case .invalidCategory:
            "Please enter a category that matches the requirements."
        case .missingCategory:
            "Communities must have at least 1 category."
        case .categoryAlreadyAdded:
            "This category has already been added."
        case .invalidTag:
            "Please enter a tag that matches the requirements."
        case .missingTag:
            "Communities must have at least 1 tag."
        case .tagAlreadyAdded:
            "This tag has already been added."
        case .missingRule:
            "Communities must have at least 1 rule."
        case .ruleAlreadyAdded:
            "This rule has already been added."
        case .invalidRuleTitle:
            "Please enter a rule title that matches the requirements."
        case .invalidRuleDescription:
            "Please enter a rule description that matches the requirements."
        }
    }
}
