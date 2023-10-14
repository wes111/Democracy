//
//  OnboardingPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

enum OnboardingPath: Hashable {
    case goToCreatePassword(CreatePasswordViewModel)
    case goToCreateEmail(CreateEmailViewModel)
    case goToCreatePhone(CreatePhoneViewModel)
    
    case goToCreateAccountSuccess(CreateAccountSuccessViewModel)
    case goToAcceptTerms(AcceptTermsViewModel)
    
    case goToVerifyEmail(EmailVerificationViewModel)
    case goToVerifyPhone(PhoneVerificationViewModel)
}
