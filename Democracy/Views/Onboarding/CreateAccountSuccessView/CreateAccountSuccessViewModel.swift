//
//  CreateAccountSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Factory
import Foundation

final class CreateAccountSuccessViewModel: ObservableObject, Hashable {
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    @Injected(\.onboardingFlowService) private var onboardingManager
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    func continueAction() {
        coordinator?.continueAccountSetup()
    }
    
    func close() {
        coordinator?.close()
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [.close : close]
    }
    
    var userName: String {
        onboardingManager.userName ?? ""
    }
}
