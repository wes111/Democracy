//
//  OnboardingAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/22/23.
//

import Foundation

enum OnboardingAlert: AlertModelProtocol {
    case invalidUsername, invalidPassword, invalidEmail,
         invalidPhone, emailUnavailable, phoneUnavailable, usernameUnavailable,
         createAccountFailed
    
    var title: String {
        switch self {
        case .invalidUsername:
            "Invalid Username"
        case .invalidPassword:
            "Invalid Password"
        case .invalidEmail:
            "Invalid Email"
        case .invalidPhone:
            "Invalid Phone Number"
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
        case .invalidUsername:
            "Enter a username that meets the requirements."
        case .invalidPassword:
            "Enter a password that meets the requirements."
        case .invalidEmail:
            "Enter an email that meets the requirements."
        case .invalidPhone:
            "Enter a phone number that meets the requirements."
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
