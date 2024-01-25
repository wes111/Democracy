//
//  PostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostBodyView: View {
    @Bindable var viewModel: PostBodyViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    var body: some View {
        UserTextEditorInputView(
            viewModel: viewModel,
            focusedField: $focusedField
        )
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostBodyViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return NavigationStack {
        PostBodyView(viewModel: viewModel)
    }
}
