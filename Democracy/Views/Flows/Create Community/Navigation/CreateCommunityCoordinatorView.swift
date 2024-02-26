//
//  CreateCommunityCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CreateCommunityCoordinatorView: View {
    @State private var coordinator: CreateCommunityCoordinator
    
    init(coordinator: CreateCommunityCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            CommunityNameView(viewModel: coordinator.communityNameViewModel)
        } secondaryScreen: { path in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: CreateCommunityPath) -> some View {
        switch path {
        case .goToCommunityDescription(let viewModel):
            CommunityDescriptionView(viewModel: viewModel)
            
        case .goToCommunityCategories(let viewModel):
            CommunityCategoriesView(viewModel: viewModel)
            
        case .goToCommunityTags(let viewModel):
            CommunityTagsView(viewModel: viewModel)
            
        case .goToCommunityRules(let viewModel):
            CommunityRulesView(viewModel: viewModel)
            
        case .goToCommunitySettings(let viewModel):
            CommunitySettingsView(viewModel: viewModel)
            
        case .goToCommunityResources(let viewModel):
            CommunityResourcesView(viewModel: viewModel)
            
        case .goToCommunitySuccess(let viewModel):
            SuccessView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    CreateCommunityCoordinatorView(coordinator: CreateCommunityCoordinator.preview)
}
