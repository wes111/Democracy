//
//  InputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import SwiftUI

// Generic. Shows an entire InputFlow, e.g. CreateCommunity, CreatePost, etc.
@MainActor
struct InputFlowView<ViewModel: InputFlowViewModel, FlowContent: View>: View {
    @Bindable var viewModel: ViewModel
    @ViewBuilder let content: FlowContent
    
    init(viewModel: ViewModel, @ViewBuilder content: () -> FlowContent) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        primaryContent
            .toolbarNavigation(
                leadingContent: viewModel.leadingButtons,
                trailingContent: viewModel.trailingButtons
            )
    }
}

// MARK: - Private Subviews
private extension InputFlowView {
    
    var primaryContent: some View {
        ZStack(alignment: .center) {
            Color.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    HorizontalProgressView(
                        totalProgress: viewModel.totalProgress,
                        currentProgress: viewModel.currentProgress
                    )
                    
                    Text(viewModel.viewTitle)
                        .primaryTitle()
                    
                    content
                        .titledElement(title: viewModel.viewSubtitle)
                }
                .padding(ViewConstants.screenPadding)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        InputFlowView(viewModel: PostInputFlowViewModel.preivew) {
            PostTitleView(viewModel: .preview)
        }
    }
}
