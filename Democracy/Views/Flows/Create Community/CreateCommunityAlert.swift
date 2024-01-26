//
//  CreateCommunityAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityAlert: AlertModelProtocol {
    case invalidName, invalidDescription, invalidCategory, missingCategory, categoryAlreadyAdded
    
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
        }
    }
}
