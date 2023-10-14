//
//  CreateAccountSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

final class CreateAccountSuccessViewModel: ObservableObject, Hashable {
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    func continueAction() {
        coordinator?.continueAccountSetup()
    }
    
    func skipAction() {
        
    }
    
    func close() {
        coordinator?.close()
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [ .close : close ]
    }
}
