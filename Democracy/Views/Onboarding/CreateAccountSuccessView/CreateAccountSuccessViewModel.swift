//
//  CreateAccountSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

final class CreateAccountSuccessViewModel: ObservableObject, Hashable {
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    private let onboardingManager: OnboardingFlowManager
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingManager: OnboardingFlowManager) {
        self.coordinator = coordinator
        self.onboardingManager = onboardingManager
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
