//
//  CreateEmailViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class CreateEmailViewModel: OnboardingUserInputViewModel<CreateEmailField>, OnboardingUserInputViewModelProtocol {
    typealias Field = CreateEmailField
    
    var submitAction: () -> Void {
        coordinator?.submitEmail ?? {}
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close, .back : goBack]
    }
}
