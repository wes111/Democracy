//
//  CreateAccountViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

protocol CreateAccountCoordinatorDelegate {
    func goToCreatePassword()
    func goBack()
}

final class CreateAccountViewModel: ObservableObject {
    
    @Published var username: String = ""
    
    private let coordinator: CreateAccountCoordinatorDelegate
    
    init(coordinator: CreateAccountCoordinatorDelegate) {
        self.coordinator = coordinator
    }
}

//MARK: - Methods
extension CreateAccountViewModel {
    func goToNext() {
        coordinator.goToCreatePassword()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
