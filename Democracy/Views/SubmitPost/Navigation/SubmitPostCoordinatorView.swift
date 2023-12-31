//
//  SubmitPostCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct SubmitPostCoordinatorView: View {
    @StateObject private var coordinator: SubmitPostCoordinator
    
    init(coordinator: SubmitPostCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        CoordinatorView(router: $coordinator.router) {
            PostTitleView(viewModel: coordinator.createPostTitleViewModel)
        } secondaryScreen: { (path: SubmitPostPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: SubmitPostPath) -> some View {
        switch path {
        case .goToPostBody(let viewModel): 
            PostBodyView(viewModel: viewModel)
            
        case .goToPostLink(let viewModel):
            PostLinkView(viewModel: viewModel)
            
        case .goToPostTags(let viewModel):
            PostTagsView(viewModel: viewModel)
            
        case .goToPostCategory(let viewModel):
            PostCategoryView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = SubmitPostCoordinator(parentCoordinator: CommunityCoordinator.preview)
    return SubmitPostCoordinatorView(coordinator: viewModel)
}
