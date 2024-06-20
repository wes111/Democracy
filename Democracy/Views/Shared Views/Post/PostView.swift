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
        commentList
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .dismissKeyboardOnDrag()
    }
    
    func listNode(_ commentNode: CommentNode) -> some View {
        Group {
            if commentNode.isLoadMoreNode {
                loadRepliesButton(for: commentNode.parentComment)
            } else {
                commentView(commentNode)
            }
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(Color.primaryBackground)
        .listRowSeparator(.hidden)
    }
    
    var commentList: some View {
        List {
            ForEach(viewModel.comments) { commentNode in
                NodeOutlineGroup(node: commentNode, childKeyPath: \.replies) { commentNode in
                    listNode(commentNode)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            AddCommentView(viewModel: viewModel, focusState: $isAddCommentFieldFocused)
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listStyle(.plain)
        .clipped()
        .disclosureGroupStyle(CommentDisclosureGroupStyle())
        .animation(.easeInOut)
    }
    
    func commentView(_ commentNode: CommentNode) -> some View {
        CommentView(viewModel: .init(comment: commentNode, delegate: viewModel))
            .padding(.horizontal, ViewConstants.screenPadding)
    }
    
    func loadRepliesButton(for comment: CommentNode?) -> some View {
        HStack {
            if let comment {
                ForEach(0...comment.depth, id: \.self) { _ in
                    Divider()
                        .overlay(Color.tertiaryText)
                        .padding(.trailing, ViewConstants.smallInnerBorder)
                }
            }
            
            AsyncButton(
                action: { await viewModel.onTapLoadReplies(comment: comment)},
                label: { Text(viewModel.loadButtonText(for: comment)) },
                showProgressView: .constant(false)
            )
            .buttonStyle(TertiaryButtonStyle())
            .padding(.vertical, ViewConstants.smallElementSpacing)
        }
        .padding(.horizontal, ViewConstants.screenPadding)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(viewModel: PostViewModel.preview)
    }
}
