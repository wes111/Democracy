//
//  PostInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import SwiftUI

struct PostInputFlowView: View {
    @Bindable var viewModel: PostInputFlowViewModel
    
    init(viewModel: PostInputFlowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        InputFlowView(viewModel: viewModel) {
            flowScreen
        }
    }
}

// MARK: - Subviews
private extension PostInputFlowView {
    @ViewBuilder
    var flowScreen: some View {
        switch viewModel.flowPath {
        case .title(let viewModel):
            PostTitleView(viewModel: viewModel)
            
        case .primaryLink(let viewModel):
            PostPrimaryLinkView(viewModel: viewModel)
            
        case .body(let viewModel):
            PostBodyView(viewModel: viewModel)
            
        case .category(let viewModel):
            PostCategoryView(viewModel: viewModel)
            
        case .tags(let viewModel):
            PostTagsView(viewModel: viewModel)
            
        case .none:
            EmptyView() // TODO: ????
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostInputFlowView(viewModel: .preivew)
    }
}
