//
//  CommunityDescriptionView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunityDescriptionView<ViewModel: CommunityDescriptionViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews
private extension CommunityDescriptionView {
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            SubmittableTextEditorInputView(viewModel: viewModel, focusedField: $focusedField) {
                field
            }
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                field: ViewModel.FocusedField.description,
                text: $viewModel.text,
                focusedField: $focusedField
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityDescriptionView(viewModel: .preview)
    }
}
