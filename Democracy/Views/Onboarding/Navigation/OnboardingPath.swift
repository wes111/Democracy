//
//  OnboardingPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

enum OnboardingPath: Hashable {
    case goToCreateAccount(CreateFieldViewModel<UserNameValidation>)
    case goToCreatePassword(CreateFieldViewModel<PasswordValidation>)
    case goToCreateEmail(CreateFieldViewModel<EmailValidation>)
    case goToCreatePhone
    
    case goToVerifyEmail
    case goToVerifyPhone
}
