//
//  CommunityInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation

protocol SubmitCommunityFlowCoordinator: AnyObject {
    @MainActor func didSubmit(flow: CommunityFlow.ID)
}

// The InputFlowViewModel for creating new Community objects.
@Observable
final class CommunityInputFlowViewModel: InputFlowViewModel, SubmitCommunityFlowCoordinator {
    var flowPath: CommunityFlow?
    private let input = SubmitCommunityInput()
    private weak var coordinator: SubmitCommunityCoordinator?
    
    init(coordinator: SubmitCommunityCoordinator?) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func didSubmit(flow: CommunityFlow.ID) {
        switch flow {
        case .name:
            let viewModel = CommunityDescriptionViewModel(submitCommunityInput: input, flowCoordinator: self)
            flowPath = .description(viewModel)
            
        case .description:
            let viewModel = CommunityCategoriesViewModel(submitCommunityInput: input, flowCoordinator: self)
            flowPath = .categories(viewModel)
            
        case .categories:
            let viewModel = CommunityTagsViewModel(submitCommunityInput: input, flowCoordinator: self)
            flowPath = .tags(viewModel)
            
        case .tags:
            let viewModel = CommunityRulesViewModel(submitCommunityInput: input, flowCoordinator: self)
            flowPath = .rules(viewModel)
            
        case .rules:
            let viewModel = CommunitySettingsViewModel(submitCommunityInput: input, flowCoordinator: self)
            flowPath = .settings(viewModel)
            
        case .settings:
            let viewModel = CommunityResourcesViewModel(submitCommunityInput: input, flowCoordinator: self)
            flowPath = .resources(viewModel)
            
        case .resources:
            coordinator?.goToSuccess()
        }
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
        shouldShowBackButton ? [.back] : []
    }
    
    var shouldShowBackButton: Bool {
        guard let flowPath else {
            return false
        }
        
        return switch flowPath {
        case .name:
            false
        case .description, .categories, .tags, .rules, .settings, .resources:
            true
        }
    }
    
    @MainActor
    func close() {
        coordinator?.close()
    }
}
