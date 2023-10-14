//
//  CreateUsernameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

final class CreateUsernameViewModel: OnboardingUserInputViewModel<CreateUsernameField>, OnboardingUserInputViewModelProtocol {
    
    typealias Field = CreateUsernameField
    
    var submitAction: () -> Void {
        coordinator?.submitUsername ?? {}
    }
    
    var topButtons: TopButtonsDictionary {
        [.close : close]
    }

}
