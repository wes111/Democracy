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
    let username: String
    @Injected(\.accountService) private var accountService
    
    init(coordinator: OnboardingCoordinatorDelegate?, username: String) {
        self.coordinator = coordinator
        self.username = username
    }
    
    lazy var primaryButtonInfo: ButtonInfo = {
        .init(title: "Continue Account Setup", action: continueAction)
    }()
    
    lazy var secondaryButtonInfo: ButtonInfo = {
        .init(title: "Skip", action: close)
    }()
    
    func continueAction() {
        coordinator?.continueAccountSetup()
    }
    
    func close() {
        coordinator?.close()
    }
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}
