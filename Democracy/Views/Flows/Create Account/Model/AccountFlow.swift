//
//  AccountFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation

enum AccountFlow: UserInputFlow {
    case username(AccountUsernameViewModel)
    case email(AccountEmailViewModel)
    case password(AccountPasswordViewModel)
    case phone(AccountPhoneViewModel)
    case acceptTerms(AccountAcceptTermsViewModel)
    
    enum ID: CaseIterable, Hashable, Equatable {
        case username, email, password, phone, acceptTerms
    }
    
    var id: ID {
        switch self {
        case .username: .username
        case .email: .email
        case .password: .password
        case .phone: .phone
        case .acceptTerms: .acceptTerms
        }
    }
    
    var progress: Int {
        switch self {
        case .username: 0
        case .email: 1
        case .password: 2
        case .phone: 3
        case .acceptTerms: 4
        }
    }
    
    var title: String {
        switch self {
        case .username: "Create a Username"
        case .password: "Create a Password"
        case .email: "Add Your Email"
        case .phone: "Add Your Phone Number"
        case .acceptTerms: "Agree to Democracy's Terms and Conditions"
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
        case .acceptTerms:
            """
            By tapping I agree, you agree to create an
            account and to Democracy's terms and privacy policy.
            """
        }
    }
}

// MARK: - PasswordCaseRepresentable
extension AccountFlow.ID: PasswordCaseRepresentable {
    
    var isPasswordCase: Bool {
        switch self {
        case .username, .email, .phone, .acceptTerms:
            false
        case .password:
            true
        }
    }
    
    static var passwordCase: AccountFlow.ID {
        Self.password
    }
}
