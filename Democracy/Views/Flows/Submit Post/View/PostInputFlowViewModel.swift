//
//  PostInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation

protocol SubmitPostFlowCoordinator: AnyObject {
    @MainActor func didSubmit(flow: PostFlow.ID)
}

// The InputFlowViewModel for creating new Post objects.
@MainActor @Observable
final class PostInputFlowViewModel: InputFlowViewModel, SubmitPostFlowCoordinator {
    var flowPath: PostFlow?
    private let input = SubmitPostInput()
    private weak var coordinator: SubmitPostCoordinator?
    
    init(coordinator: SubmitPostCoordinator) {
        self.coordinator = coordinator
        flowPath = .title(.init(input: input, flowCoordinator: self))
    }
    
    func didSubmit(flow: PostFlow.ID) {
        switch flow {
        case .title: toPrimaryLink()
        case .primaryLink: toBody()
        case .body: toCategory()
        case .category: toTags()
        case .tags: coordinator?.goToSuccess()
        }
    }
    
    func goBack() {
        switch flowPath {
        case .title, nil: return
        case .primaryLink: toTitle()
        case .body: toPrimaryLink()
        case .category: toBody()
        case .tags: toTags()
        }
    }
    
    var shouldShowBackButton: Bool {
        guard let flowPath else {
            return false
        }
        
        return switch flowPath {
        case .title:
            false
        case .primaryLink, .body, .tags, .category:
            true
        }
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [ToolBarLeadingContent] {
        shouldShowBackButton ? [.back(goBack)] : []
    }
    
    func close() {
        coordinator?.close()
    }
}

// MARK: - Private Methods
private extension PostInputFlowViewModel {
    
    func toTitle() {
        let viewModel = PostTitleViewModel(input: input, flowCoordinator: self)
        flowPath = .title(viewModel)
    }
    
    func toPrimaryLink() {
        let viewModel = PostPrimaryLinkViewModel(submitPostInput: input, flowCoordinator: self)
        flowPath = .primaryLink(viewModel)
    }
    
    func toBody() {
        let viewModel = PostBodyViewModel(submitPostInput: input, flowCoordinator: self)
        flowPath = .body(viewModel)
    }
    
    func toCategory() {
        let viewModel = PostCategoryViewModel(submitPostInput: input, flowCoordinator: self)
        flowPath = .category(viewModel)
    }
    
    func toTags() {
        let viewModel = PostTagsViewModel(submitPostInput: input, flowCoordinator: self)
        flowPath = .tags(viewModel)
    }
}
