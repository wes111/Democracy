//
//  CreateAccountSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

final class CreateAccountSuccessViewModel: Hashable {
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    let username: String
    
    init(coordinator: OnboardingCoordinatorDelegate?, username: String) {
        self.coordinator = coordinator
        self.username = username
    }
}

// MARK: - Computed Properties
extension CreateAccountSuccessViewModel {
    
    var primaryButtonInfo: ButtonInfo {
        .init(title: "Continue Account Setup", action: continueAction)
    }
    
    var secondaryButtonInfo: ButtonInfo {
        .init(title: "Skip", action: close)
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension CreateAccountSuccessViewModel {
    
    @MainActor
    func continueAction() {
        coordinator?.continueAccountSetup()
    }
    
    @MainActor
    func close() {
        coordinator?.close()
    }
}
