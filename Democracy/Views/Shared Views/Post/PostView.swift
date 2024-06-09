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
            .alertableModifier(alertModel: $viewModel.alertModel)
            .onChange(of: viewModel.replyingToComment) { _, newValue in
                isAddCommentFieldFocused = newValue != nil
            }
            .onChange(of: isAddCommentFieldFocused ?? false) { _, isFocused in
                if !isFocused {
                    viewModel.replyingToComment = nil
                }
            }
            .task {
                await viewModel.fetchInitialComments()
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
            OutlineGroup(viewModel.comments, id: \.value, children: \.replies) { commentNode in
                
                if commentNode.isLoadMoreNode {
                    loadRepliesButton(for: commentNode.parentComment)
                } else {
                    let viewModel = CommentViewModel(comment: commentNode)
                    CommentView(viewModel: viewModel)
                        .padding(.horizontal, ViewConstants.screenPadding)
                        .padding(.vertical, ViewConstants.screenPadding / 2)
                        .onAppear {
                            viewModel.delegate = self.viewModel
                        }
                }
            }
            .disclosureGroupStyle(CommentDisclosureGroupStyle())
            .animation(.easeInOut)
            
            AddCommentView(viewModel: viewModel, focusState: $isAddCommentFieldFocused).hidden()
        }
        .clipped()
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    func loadRepliesButton(for comment: CommentNode?) -> some View {
        AsyncButton(
            action: { await viewModel.onTapLoadReplies(comment: comment)},
            label: { Text("Load Replies") },
            showProgressView: .constant(false)
        )
        .buttonStyle(PrimaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(viewModel: PostViewModel.preview)
    }
}
