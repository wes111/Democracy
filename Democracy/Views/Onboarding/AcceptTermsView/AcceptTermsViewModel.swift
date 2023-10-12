//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

protocol AcceptTermsCoordinatorDelegate: AnyObject {
    func goToCreateAccountSuccess()
}

final class AcceptTermsViewModel: ObservableObject, Hashable {
    
    private weak var coordinator: AcceptTermsCoordinatorDelegate?
    
    init(coordinator: AcceptTermsCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    func tapAgree() {
        coordinator?.goToCreateAccountSuccess()
    }
    
}

