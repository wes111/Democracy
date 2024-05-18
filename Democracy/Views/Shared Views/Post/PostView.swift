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
    }
    
    func comment(_ node: Node<Comment>) -> some View {
        Text(node.value.content)
            .foregroundStyle(Color.secondaryText)
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(viewModel: PostViewModel.preview)
    }
}
