//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

protocol AcceptTermsCoordinatorDelegate {
    func goToCreateAccountSuccess()
}

final class AcceptTermsViewModel: ObservableObject, Hashable {
    
    private let coordinator: AcceptTermsCoordinatorDelegate
    
    init(coordinator: AcceptTermsCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func tapAgree() {
        coordinator.goToCreateAccountSuccess()
    }
    
}

