//
//  CreateAccountSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

protocol CreateAccountSuccessCoordinatorDelegate: AnyObject {
    func close()
    func continueAccountSetup()
}

final class CreateAccountSuccessViewModel: ObservableObject, Hashable {
    
    private weak var coordinator: CreateAccountSuccessCoordinatorDelegate?
    init(coordinator: CreateAccountSuccessCoordinatorDelegate?) {
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
        [
            .back : {},
            .close : close
        ]
    }
}
