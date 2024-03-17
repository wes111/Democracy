//
//  PostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

@MainActor
struct PostBodyView<ViewModel: PostBodyViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
    }
}

// MARK: - Subviews
private extension PostBodyView {
    var primaryContent: some View {
        SubmittableTextEditorInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack {
                field
                Spacer()
                SubmittableNextButton(viewModel: viewModel)
            }
        }
    }
    
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                field: ViewModel.FocusedField.body,
                text: $viewModel.text,
                focusedField: $focusedField
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostBodyView(viewModel: .preview)
    }
}
