//
//  SubmitPostCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

protocol SubmitPostCoordinatorParent: AnyObject {
    func dismiss()
}

final class SubmitPostCoordinator: Coordinator {
    
    weak var parentCoordinator: SubmitPostCoordinatorParent?
    
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
        let viewModel = PostSuccessViewModel(coordinator: self)
        router.push(SubmitPostPath.goToPostSuccess(viewModel))
    }
}
