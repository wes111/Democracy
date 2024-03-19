//
//  OnboardingCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

@MainActor
protocol CreateAccountCoordinatorParent: AnyObject {
    func dismiss()
}

@MainActor @Observable
final class CreateAccountCoordinator {
    private weak var parentCoordinator: CreateAccountCoordinatorParent?
    var router = Router()
    
    init(parentCoordinator: CreateAccountCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    var accountInputFlowViewModel: AccountInputFlowViewModel {
        .init(coordinator: self)
    }
}

extension CreateAccountCoordinator: CreateAccountCoordinatorDelegate {
    func goToSuccess() {
        let viewModel = CreateAccountSuccessViewModel(closeAction: close, continueAction: continueAction, username: "") // TODO: Add username...
        router.push(CreateAccountPath.goToSuccess(viewModel))
    }
    
    func close() {
        parentCoordinator?.dismiss()
    }
    
    func goBack() {
        router.pop()
    }
    
    func continueAction() {
        // TODO: ...
    }
}
