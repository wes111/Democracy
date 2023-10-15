//
//  EmailVerificationViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class EmailVerificationViewModel: OnboardingUserInputViewModel<VerifyEmailField>, OnboardingUserInputViewModelProtocol {
    typealias Field = VerifyEmailField
    
    override func submit() {
        super.submit()
        coordinator?.submitEmailVerification()
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
}
