//
//  CreatePhoneViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class CreatePhoneViewModel: OnboardingUserInputViewModel<CreatePhoneField>, OnboardingUserInputViewModelProtocol {
    typealias Field = CreatePhoneField
    
    override func submit() {
        super.submit()
        coordinator?.submitPhone()
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
}
