//
//  PostSecondaryLinksView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import SwiftUI

struct PostSecondaryLinksView<ViewModel: PostSecondaryLinksViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            todoView
        }
        .onAppear {
            focusedField = viewModel.field
            viewModel.onAppear()
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

// MARK: - Subviews
private extension PostSecondaryLinksView {
    var todoView: some View {
        field
    }
    
    var field: some View {
        TextField(
            "Secondary Link",
            text: $viewModel.text,
            prompt: Text("Secondary Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(
            link: $viewModel.text,
            focusedField: $focusedField,
            textErrors: viewModel.textErrors
        ))
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostSecondaryLinksViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return NavigationStack {
        PostSecondaryLinksView(viewModel: viewModel)
    }
        
}
