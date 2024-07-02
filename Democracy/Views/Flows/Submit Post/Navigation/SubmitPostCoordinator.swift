//
//  SubmitPostCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@MainActor
protocol SubmitPostCoordinatorParent: AnyObject {
    func dismissSubmitPostView()
}

@MainActor @Observable
final class SubmitPostCoordinator {
    
    weak var parentCoordinator: SubmitPostCoordinatorParent?
    var router = Router()
    
    init(parentCoordinator: SubmitPostCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    var postInputFlowViewModel: PostInputFlowViewModel {
        .init(coordinator: self)
    }
}

extension SubmitPostCoordinator: SubmitPostCoordinatorDelegate {
    func close() {
        parentCoordinator?.dismissSubmitPostView()
    }
    
    func goBack() {
        router.pop()
    }
    
    func goToSuccess() {
        router.push(SubmitPostPath.goToPostSuccess(.init(closeAction: close)))
    }
}
