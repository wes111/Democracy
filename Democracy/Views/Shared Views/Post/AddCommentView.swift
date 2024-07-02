//
//  AddCommentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/30/24.
//

import SwiftUI

// TODO: Add a cancel button as a keyboard tool...
@MainActor
struct AddCommentView: View {
    @State private var viewModel: PostViewModel
    @FocusState.Binding var isAddCommentFieldFocused: Bool?
    
    init(viewModel: PostViewModel, focusState: FocusState<Bool?>.Binding) {
        self.viewModel = viewModel
        self._isAddCommentFieldFocused = focusState
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension AddCommentView {
    
    var content: some View {
        VStack(spacing: ViewConstants.smallElementSpacing) {
            Divider()
                .overlay(Color.black)
            
            VStack(spacing: ViewConstants.elementSpacing) {
                if let isAddCommentFieldFocused, isAddCommentFieldFocused {
                    header
                }
                
                HStack(spacing: ViewConstants.smallElementSpacing) {
                    textEditor
                    sendButton
                }
            }
            .padding([.horizontal, .bottom], ViewConstants.screenPadding)
        }
        .background(Color.primaryBackground)
    }
    
    var sendButton: some View {
        AsyncButton(
            action: {
                await viewModel.submitComment()
            },
            label: {
                Image(systemName: SystemImage.paperPlane.rawValue)
                    .font(.title2)
                    .foregroundStyle(Color.secondaryText)
            },
            showProgressView: $viewModel.isLoading)
    }
    
    var header: some View {
        HStack {
            description
            Spacer()
        }
    }
    
    var description: some View {
        Text(viewModel.replyText)
            .foregroundStyle(Color.tertiaryText)
            .font(.footnote)
    }
    
    var textEditor: some View {
        TextEditor(text: $viewModel.commentText)
            .standarCommentStyle(
                field: true,
                text: $viewModel.commentText,
                focusedField: $isAddCommentFieldFocused,
                placeHolder: "Add your comment..."
            )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: Bool?
    
    return ZStack {
        AddCommentView(viewModel: .preview, focusState: $focusedField)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .background(Color.primaryBackground)
}
