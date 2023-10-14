//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

final class AcceptTermsViewModel: ObservableObject, Hashable {
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [
            .back : {},
            .close : close
        ]
    }
    
    func tapAgree() {
        coordinator?.agreeToTerms()
    }
    
    func close() {
        coordinator?.close()
    }
    
}

