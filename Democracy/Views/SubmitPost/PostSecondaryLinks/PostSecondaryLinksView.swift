//
//  PostSecondaryLinksView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import SwiftUI

struct PostSecondaryLinksView: View {
    @ObservedObject var viewModel: PostSecondaryLinksViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    init(viewModel: PostSecondaryLinksViewModel) {
        self.viewModel = viewModel
    }
    
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
        .textFieldStyle(LinkTextFieldStyle(link: $viewModel.text))
        .requirements(
            text: viewModel.text,
            allPossibleErrors: viewModel.allErrors,
            textErrors: viewModel.textErrors
        )
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = viewModel.field
        }
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
