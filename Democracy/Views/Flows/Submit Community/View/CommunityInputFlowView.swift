//
//  CommunityInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import SwiftUI

@MainActor
struct CommunityInputFlowView: View {
    @Bindable var viewModel: CommunityInputFlowViewModel
    
    init(viewModel: CommunityInputFlowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        InputFlowView(viewModel: viewModel) {
            flowScren
        }
        .animation(.easeInOut, value: viewModel.flowPath?.id)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Subviews
private extension CommunityInputFlowView {
    @ViewBuilder
    var flowScren: some View {
        switch viewModel.flowPath {
        case .name(let viewModel):
            CommunityNameView(viewModel: viewModel)
            
        case .tagline(let viewModel):
            CommunityTaglineView(viewModel: viewModel)
            
        case .description(let viewModel):
            CommunityDescriptionView(viewModel: viewModel)
            
        case .categories(let viewModel):
            CommunityCategoriesView(viewModel: viewModel)
            
        case .tags(let viewModel):
            CommunityTagsView(viewModel: viewModel)
            
        case .rules(let viewModel):
            CommunityRulesView(viewModel: viewModel)
            
        case .settings(let viewModel):
            CommunitySettingsView(viewModel: viewModel)
            
        case .resources(let viewModel):
            CommunityResourcesView(viewModel: viewModel)
            
        case .none:
            EmptyView() // TODO: ????
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(viewModel: .preview)
    }
}
