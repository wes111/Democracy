//
//  SubmitPostCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@MainActor
protocol SubmitPostCoordinatorParent: AnyObject {
    func dismiss()
}

@MainActor @Observable
final class SubmitPostCoordinator {
    
    weak var parentCoordinator: SubmitPostCoordinatorParent?
    var router = Router()
    
    init(parentCoordinator: SubmitPostCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    var createPostTitleViewModel: PostTitleViewModel {
        .init(coordinator: self)
    }
}

// MARK: - Single NEW protocool.
extension SubmitPostCoordinator: SubmitPostCoordinatorDelegate {
    func didFinish() {
        close()
    }
    
    func didSubmitTitle(input: SubmitPostInput) {
        let viewModel = PostPrimaryLinkViewModel(coordinator: self, submitPostInput: input)
        router.push(SubmitPostPath.goToPostPrimaryLink(viewModel))
    }
    
    func close() {
        parentCoordinator?.dismiss()
    }
    
    func goBack() {
        router.pop()
    }
    
    func didSubmitLink(input: SubmitPostInput) {
        let viewModel = PostBodyViewModel(coordinator: self, submitPostInput: input)
        router.push(SubmitPostPath.goToPostBody(viewModel))
    }
    
    func didSubmitBody(input: SubmitPostInput) {
        let viewModel = PostCategoryViewModel(coordinator: self, submitPostInput: input)
        router.push(SubmitPostPath.goToPostCategory(viewModel))
    }
    
    func didSubmitCategory(input: SubmitPostInput) {
        let viewModel = PostTagsViewModel(coordinator: self, submitPostInput: input)
        router.push(SubmitPostPath.goToPostTags(viewModel))
    }
    
    func didSubmitTags(input: SubmitPostInput) {
        let viewModel = PostSuccessViewModel(closeAction: self.close)
        router.push(SubmitPostPath.goToPostSuccess(viewModel))
    }
}
