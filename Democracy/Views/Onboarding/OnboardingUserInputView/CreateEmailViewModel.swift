//
//  CreateEmailViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class CreateEmailViewModel: OnboardingUserInputViewModel<CreateEmailField>, OnboardingUserInputViewModelProtocol {
    typealias Field = CreateEmailField
    
    override func submit() {
        super.submit()
        coordinator?.submitEmail()
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close, .back : goBack]
    }
}
