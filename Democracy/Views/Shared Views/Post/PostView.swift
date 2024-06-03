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
    @FocusState private var isAddCommentFieldFocused: Bool?
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .toolbarNavigation(
                leadingContent: viewModel.leadingContent,
                centerContent: viewModel.centerContent,
                trailingContent: viewModel.trailingContent
            )
            .onAppear {
                viewModel.test()
            }
            .onChange(of: viewModel.replyingToComment) { _, newValue in
                isAddCommentFieldFocused = newValue != nil
            }
            .onChange(of: isAddCommentFieldFocused ?? false) { _, isFocused in
                if !isFocused {
                    viewModel.replyingToComment = nil
                }
            }
    }
}

// MARK: - Subviews
private extension PostView {
    var content: some View {
        ZStack(alignment: .bottomLeading) {
            commentScrollView
            AddCommentView(viewModel: viewModel, focusState: $isAddCommentFieldFocused)
        }
        .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
        .dismissKeyboardOnDrag()
    }
    
    var commentScrollView: some View {
        ScrollView(.vertical) {
            // TODO: Ideally ScrollView would be a List...
            OutlineGroup(viewModel.testComments, id: \.value, children: \.children) { commentNode in
                CommentView(viewModel: .init(
                    comment: commentNode.value,
                    didTapReply: viewModel.onTapCommentReply
                ))
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
