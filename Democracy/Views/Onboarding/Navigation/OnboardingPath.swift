//
//  OnboardingPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

enum OnboardingPath: Hashable {
    case goToCreatePassword(OnboardingUserInputViewModel<PasswordValidator>)
    case goToCreateEmail(OnboardingUserInputViewModel<EmailValidator>)
    case goToCreatePhone(OnboardingUserInputViewModel<PhoneValidator>)
    
    case goToCreateAccountSuccess(CreateAccountSuccessViewModel)
    case goToAcceptTerms(AcceptTermsViewModel)
    
    case goToVerifyEmail(OnboardingUserInputViewModel<VerifyEmailValidator>)
    case goToVerifyPhone(OnboardingUserInputViewModel<VerifyPhoneValidator>)
}
