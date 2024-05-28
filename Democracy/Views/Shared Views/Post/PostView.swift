//
//  PostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

@MainActor
struct PostView: View {
    @State private var viewModel: PostViewModel
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: viewModel.leadingContent,
                centerContent: viewModel.centerContent,
                trailingContent: viewModel.trailingContent
            )
            .onAppear {
                viewModel.test()
            }
    }
}

// MARK: - Subviews
private extension PostView {
    var content: some View {
        ZStack(alignment: .bottomLeading) {
            commentScrollView
            AddCommentView(viewModel: viewModel.addCommentViewModel)
        }
        .dismissKeyboardOnDrag()
    }
    
    var commentScrollView: some View {
        ScrollView(.vertical) {
            // TODO: Ideally ScrollView would be a List...
            OutlineGroup(viewModel.testComments, id: \.value, children: \.children) { commentNode in
                CommentView(viewModel: .init(comment: commentNode.value))
                    .padding(.horizontal, ViewConstants.screenPadding)
                    .padding(.vertical, ViewConstants.screenPadding / 2)
            }
            .disclosureGroupStyle(CommentDisclosureGroupStyle())
        }
        .clipped()
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(viewModel: PostViewModel.preview)
    }
}

@MainActor @Observable
final class AddCommentViewModel {
    var commentText: String = ""
    let replyText: String
    
    init(replyText: String) {
        self.replyText = replyText
    }
}

@MainActor
struct AddCommentView: View {
    @State private var viewModel: AddCommentViewModel
    @FocusState private var isAddCommentFieldFocused: Bool?
    
    init(viewModel: AddCommentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .onAppear {
                isAddCommentFieldFocused = true
            }
    }
    
    var content: some View {
        VStack {
            if let isAddCommentFieldFocused, isAddCommentFieldFocused {
                HStack {
                    Text(viewModel.replyText)
                    Text("Cancel Button")
                }
            }
            
            HStack {
                textEditor
                if !viewModel.commentText.isEmpty {
                    Image(systemName: SystemImage.paperPlane.rawValue)
                }
            }
        }
        .padding(ViewConstants.screenPadding)
        .background(Color.primaryBackground)
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
