//
//  CommunityTaglineView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/13/24.
//

import SwiftUI

@MainActor
struct CommunityTaglineView<ViewModel: CommunityTaglineViewModel>: View {
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
private extension CommunityTaglineView {
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack {
                field
                Spacer()
                SubmittableNextButton(viewModel: viewModel)
            }
        }
    }
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .tagline
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityTaglineView(viewModel: .preview)
    }
}
