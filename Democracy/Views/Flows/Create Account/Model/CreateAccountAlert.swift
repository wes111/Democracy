//
//  OnboardingAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/22/23.
//

import Foundation

enum CreateAccountAlert: AlertModelProtocol {
    case emailUnavailable, phoneUnavailable, usernameUnavailable, createAccountFailed
    
    var title: String {
        switch self {
        case .emailUnavailable:
            "Email Unavailable"
        case .phoneUnavailable:
            "Phone Number Unavailable"
        case .usernameUnavailable:
            "Username unavailable"
        case .createAccountFailed:
            "Create Account Failed"
        }
    }
    
    var description: String {
        switch self {
        case .emailUnavailable:
            "Please enter a different email to continue."
        case .phoneUnavailable:
            "Please enter a different phone number to continue."
        case .usernameUnavailable:
            "Please enter a different username to continue."
        case .createAccountFailed:
            "Please try again later."
        }
    }
}
