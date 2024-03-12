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
    
    func goToSuccess() {
        let viewModel = CreateCommunitySuccessViewModel(communityName: "", closeAction: close) // TODO: Add Community Name here...
        router.push(SubmitCommunityPath.goToSuccess(viewModel))
    }
}
