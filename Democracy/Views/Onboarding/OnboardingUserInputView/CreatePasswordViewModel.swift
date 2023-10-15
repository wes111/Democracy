//
//  CreatePasswordViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class CreatePasswordViewModel: OnboardingUserInputViewModel<CreatePasswordField>, OnboardingUserInputViewModelProtocol {
    typealias Field = CreatePasswordField
    
    override func submit() {
        super.submit()
        coordinator?.submitPassword()
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close, .back : goBack]
    }
}
