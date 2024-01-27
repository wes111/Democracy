//
//  CreateAccountFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/23/24.
//

import Foundation

enum CreateAccountFlow: Int, UserInputFlow {
    case username = 0
    case password = 1
    case email = 2
    case phone = 3
}

// MARK: - Computed Properties
extension CreateAccountFlow {
    
    var title: String {
        switch self {
        case .username:
            "Create a Username"
        case .password:
            "Create a Password"
        case .email:
            "Add Your Email"
        case .phone:
            "Add Your Phone Number"
        }
    }
    
    var subtitle: String {
        switch self {
        case .username:
            "Create a unique username for your account."
        case .password:
            "Create a password that meets the password requirements listed below."
        case .email:
            "Add a primary email for your account."
        case .phone:
            "Add a phone number to receive SMS notifications."
        }
    }
    
    var required: Bool {
        switch self {
        case .username, .password, .email:
            true
        case .phone:
            false
        }
    }
}
