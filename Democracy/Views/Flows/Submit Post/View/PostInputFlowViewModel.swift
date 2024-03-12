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
@Observable 
final class PostInputFlowViewModel: InputFlowViewModel, SubmitPostFlowCoordinator {
    var flowPath: PostFlow?
    private let input = SubmitPostInput()
    private weak var coordinator: SubmitPostCoordinator?
    
    init(coordinator: SubmitPostCoordinator) {
        self.coordinator = coordinator
        flowPath = .title(.init(input: input, flowCoordinator: self))
    }
    
    @MainActor
    func didSubmit(flow: PostFlow.ID) {
        switch flow {
        case .title:
            let viewModel = PostPrimaryLinkViewModel(submitPostInput: input, flowCoordinator: self)
            flowPath = .primaryLink(viewModel)
            
        case .primaryLink:
            let viewModel = PostBodyViewModel(submitPostInput: input, flowCoordinator: self)
            flowPath = .body(viewModel)
            
        case .body:
            let viewModel = PostCategoryViewModel(submitPostInput: input, flowCoordinator: self)
            flowPath = .category(viewModel)
            
        case .category:
            let viewModel = PostTagsViewModel(submitPostInput: input, flowCoordinator: self)
            flowPath = .tags(viewModel)
            
        case .tags:
            coordinator?.goToSuccess()
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
    
    var leadingButtons: [OnboardingTopButton] {
        shouldShowBackButton ? [.back] : []
    }
    
    @MainActor
    func close() {
        coordinator?.close()
    }
}
