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
    
    lazy var createPostTitleViewModel: PostTitleViewModel = {
        .init(coordinator: self)
    }()
    
    deinit {
        print()
    }
}

// MARK: - Single NEW protocool.
extension SubmitPostCoordinator: SubmitPostCoordinatorDelegate {
    func close() {
        parentCoordinator?.dismiss()
    }
    
    func goBack() {
        router.pop()
    }
    
    func didSubmitTitle() {
        let viewModel = PostLinkViewModel(coordinator: self)
        router.push(SubmitPostPath.goToPostLink(viewModel))
    }
    
    func didSubmitLink() {
        let viewModel = PostBodyViewModel(coordinator: self)
        router.push(SubmitPostPath.goToPostBody(viewModel))
    }
    
    func didSubmitBody() {
        let viewModel = PostTagsViewModel(coordinator: self)
        router.push(SubmitPostPath.goToPostTags(viewModel))
    }
    
    func didSubmitTags() {
        // TODO: ...
        close()
    }
}
