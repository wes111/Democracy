//
//  CreateCommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor
protocol CreateCommunityCoordinatorParent: AnyObject {
    func dismiss()
}

@MainActor @Observable
final class CreateCommunityCoordinator {
    weak var parentCoordinator: CreateCommunityCoordinatorParent?
    var router = Router()
    
    init(parentCoordinator: CreateCommunityCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    var communityNameViewModel: CommunityNameViewModel {
        .init(coordinator: self)
    }
}

extension CreateCommunityCoordinator: CreateCommunityCoordinatorDelegate {
    
    func didSubmitName(input: CreateCommunityInput) {
        let viewModel = CommunityDescriptionViewModel(
            coordinator: self,
            userInput: input
        )
        router.push(CreateCommunityPath.goToCommunityDescription(viewModel))
    }
    
    func didSubmitDescription(input: CreateCommunityInput) {
        let viewModel = CommunityCategoriesViewModel(
            coordinator: self,
            userInput: input
        )
        router.push(CreateCommunityPath.goToCommunityCategories(viewModel))
    }
    
    func didSubmitCategories(input: CreateCommunityInput) {
        let viewModel = CommunityTagsViewModel(
            coordinator: self,
            userInput: input
        )
        router.push(CreateCommunityPath.goToCommunityTags(viewModel))
    }
    
    func didSubmitTags(input: CreateCommunityInput) {
        let viewModel = CommunityRulesViewModel(
            coordinator: self,
            userInput: input
        )
        router.push(CreateCommunityPath.goToCommunityRules(viewModel))
    }
    
    func didSubmitRules(input: CreateCommunityInput) {
        let viewModel = CommunitySettingsViewModel(
            coordinator: self,
            userInput: input
        )
        router.push(CreateCommunityPath.goToCommunitySettings(viewModel))
    }
    
    func didSubmitSettings(input: CreateCommunityInput) {
        let viewModel = CommunityLeadersViewModel()
        router.push(CreateCommunityPath.goToCommunityLeaders(viewModel))
    }
    
    func didSubmitLeaders(input: CreateCommunityInput) {
        print("Add success View and viewModel")
    }
    
    func goBack() {
        router.pop()
    }
    
    func close() {
        parentCoordinator?.dismiss()
    }
}
