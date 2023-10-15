//
//  PhoneVerificationViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class PhoneVerificationViewModel: OnboardingUserInputViewModel<VerifyPhoneField>, OnboardingUserInputViewModelProtocol {
    typealias Field = VerifyPhoneField
    
    override func submit() {
        super.submit()
        coordinator?.submitPhoneVerification()
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
}
