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
    case goToCreatePhone(CreateFieldViewModel<PhoneOnboarding>)
    
    case goToCreateAccountSuccess(CreateAccountSuccessViewModel)
    case goToAcceptTerms(AcceptTermsViewModel)
    
    case goToVerifyEmail(CreateFieldViewModel<VerifyEmailOnboarding>)
    case goToVerifyPhone(CreateFieldViewModel<VerifyPhoneOnboarding>)
}
