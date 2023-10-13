//
//  OnboardingPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

enum OnboardingPath: Hashable {
    case goToCreatePassword(CreateFieldViewModel<PasswordOnboarding>)
    case goToCreateEmail(CreateFieldViewModel<EmailOnboarding>)
    case goToCreatePhone
    
    case goToCreateAccountSuccess(CreateAccountSuccessViewModel)
    case goToAcceptTerms(AcceptTermsViewModel)
    
    case goToVerifyEmail
    case goToVerifyPhone
}
