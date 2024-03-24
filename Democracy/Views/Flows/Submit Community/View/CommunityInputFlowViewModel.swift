//
//  CommunityInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation

@MainActor
protocol SubmitCommunityFlowCoordinator: AnyObject {
    func didSubmit(flow: CommunityFlow.ID)
}

// The InputFlowViewModel for creating new Community objects.
@MainActor @Observable
final class CommunityInputFlowViewModel: InputFlowViewModel, SubmitCommunityFlowCoordinator {
    var flowPath: CommunityFlow?
    private let input = SubmitCommunityInput()
    private weak var coordinator: SubmitCommunityCoordinator?
    
    init(coordinator: SubmitCommunityCoordinator?) {
        self.coordinator = coordinator
    }
    
    func onAppear() {
        flowPath = .name(.init(submitCommunityInput: input, flowCoordinator: self))
    }
    
    func goBack() {
        switch flowPath {
        case .name, nil: return
        case .description: toName()
        case .categories: toDescription()
        case .tags: toCategories()
        case .rules: toTags()
        case .settings: toRules()
        case .resources: toSettings()
        }
    }
    
    func didSubmit(flow: CommunityFlow.ID) {
        switch flow {
        case .name: toDescription()
        case .description: toCategories()
        case .categories: toTags()
        case .tags: toRules()
        case .rules: toSettings()
        case .settings: toResources()
        case .resources: coordinator?.goToSuccess(communityName: input.name ?? "") // TODO: Should not be empty String...
        }
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [ToolBarLeadingContent] {
        shouldShowBackButton ? [.back(goBack)] : []
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
    
    func close() {
        coordinator?.close()
    }
}

private extension CommunityInputFlowViewModel {
    
    func toName() {
        let viewModel = CommunityNameViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .name(viewModel)
    }
    
    func toDescription() {
        let viewModel = CommunityDescriptionViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .description(viewModel)
    }
    
    func toCategories() {
        let viewModel = CommunityCategoriesViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .categories(viewModel)
    }
    
    func toTags() {
        let viewModel = CommunityTagsViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .tags(viewModel)
    }
    
    func toRules() {
        let viewModel = CommunityRulesViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .rules(viewModel)
    }
    
    func toSettings() {
        let viewModel = CommunitySettingsViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .settings(viewModel)
    }
    
    func toResources() {
        let viewModel = CommunityResourcesViewModel(submitCommunityInput: input, flowCoordinator: self)
        flowPath = .resources(viewModel)
    }
}
