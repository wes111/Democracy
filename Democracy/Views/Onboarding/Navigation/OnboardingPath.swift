//
//  OnboardingPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

enum OnboardingPath: Hashable {
    case goToCreatePassword(PasswordInputViewModel)
    case goToCreateEmail(EmailInputViewModel)
    case goToCreatePhone(PhoneInputViewModel)
    
    case goToCreateAccountSuccess(CreateAccountSuccessViewModel)
    case goToAcceptTerms(AcceptTermsViewModel)
}
