//
//  SubmitPostCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct SubmitPostCoordinatorView: View {
    @State private var coordinator: SubmitPostCoordinator
    
    init(coordinator: SubmitPostCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            PostTitleView(viewModel: coordinator.createPostTitleViewModel)
        } secondaryScreen: { (path: SubmitPostPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: SubmitPostPath) -> some View {
        switch path {
        case .goToPostBody(let viewModel): 
            PostBodyView(viewModel: viewModel)
            
        case .goToPostPrimaryLink(let viewModel):
            PostPrimaryLinkView(viewModel: viewModel)
            
        case .goToPostTags(let viewModel):
            PostTagsView(viewModel: viewModel)
            
        case .goToPostCategory(let viewModel):
            PostCategoryView(viewModel: viewModel)
            
        case .goToPostSuccess(let viewModel):
            PostSuccessView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    SubmitPostCoordinatorView(coordinator: SubmitPostCoordinator.preview)
}
