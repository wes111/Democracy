//
//  CreateCommunityAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityAlert: AlertModelProtocol {
    case invalidName, invalidDescription
    
    var title: String {
        switch self {
        case .invalidName:
            "Invalid Name"
        case .invalidDescription:
            "Invalid Description"
        }
    }
    
    var description: String {
        switch self {
        case .invalidName:
            "This name is already in use. Please enter a new name."
        case .invalidDescription:
            "Please enter a description that matches the requirements."
        }
    }
}
