//
//  CreatePhoneViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class CreatePhoneViewModel: OnboardingUserInputViewModel<CreatePhoneField>, OnboardingUserInputViewModelProtocol {
    typealias Field = CreatePhoneField
    
    var submitAction: () -> Void {
        coordinator?.submitPhone ?? {}
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
}
