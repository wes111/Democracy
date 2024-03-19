//
//  CreateCommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor
protocol SubmitCommunityCoordinatorParent: AnyObject {
    func dismiss()
}

@MainActor @Observable
final class SubmitCommunityCoordinator {
    weak var parentCoordinator: SubmitCommunityCoordinatorParent?
    var router = Router()
    
    init(parentCoordinator: SubmitCommunityCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    var communityInputFlowViewModel: CommunityInputFlowViewModel {
        .init(coordinator: self)
    }
}

extension SubmitCommunityCoordinator: SubmitCommunityCoordinatorDelegate {
    func goBack() {
        router.pop()
    }
    
    func close() {
        parentCoordinator?.dismiss()
    }
    
    func goToSuccess(communityName: String) {
        let viewModel = CreateCommunitySuccessViewModel(communityName: communityName, closeAction: close)
        router.push(SubmitCommunityPath.goToSuccess(viewModel))
    }
}
