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
    }
}

// MARK: - Subviews
private extension PostView {
    var content: some View {
        ScrollView(.vertical) {
            // TODO: Ideally this would be a list...
            OutlineGroup(viewModel.testComments, id: \.value, children: \.children) { commentNode in
                CommentCell(comment: commentNode.value)
                    .padding(.horizontal, ViewConstants.screenPadding)
                    .padding(.vertical, ViewConstants.screenPadding / 2)
            }
            .disclosureGroupStyle(CustomDisclosureGroupStyle())
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

// Custom style for CommentCells.
struct CustomDisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .bottomLeading) {
            configuration.label
            loadRepliesButton(configuration)
                .padding(.leading, ViewConstants.screenPadding)
                .padding(.vertical, ViewConstants.screenPadding / 2)
        }
        
        if configuration.isExpanded {
            replies(configuration)
        }
    }
    
    func replies(_ configuration: Configuration) -> some View {
        HStack {
            Divider()
                .overlay(Color.tertiaryText)
                .padding(.leading, ViewConstants.screenPadding)
            
            VStack {
                configuration.content
                    .disclosureGroupStyle(self)
            }
        }
    }
    
    func loadRepliesButton(_ configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isExpanded.toggle()
            }
        } label: {
            Label(
                title: { Text("\(configuration.isExpanded ? "Hide" : "View") Replies") },
                icon: {
                    Image(systemName: configuration.isExpanded ? SystemImage.chevronUp.rawValue : SystemImage.chevronDown.rawValue)
                }
            )
            .labelStyle(ReversedLabelStyle())
            .font(.footnote)
        }
        .foregroundStyle(Color.white)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(viewModel: PostViewModel.preview)
    }
}

// MARK: - CommentCell
struct CommentCell: View {
    
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            header
            commentText
            footer
        }
    }
    
    var commentText: some View {
        Text(comment.content)
            .foregroundStyle(Color.secondaryText)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Header
private extension CommentCell {
    var header: some View {
        HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
           userIcon
            
            VStack(alignment: .leading, spacing: 0) {
                headerTopLine
                headerBottomLine
            }
        }
    }
    
    var headerTopLine: some View {
        HStack {
            Text("Bernie Sanders")
            Spacer()
            Image(systemName: SystemImage.ellipsis.rawValue)
        }
        .foregroundStyle(Color.secondaryText)
        .font(.caption2)
    }
    
    var headerBottomLine: some View {
        HStack(alignment: .center, spacing: ViewConstants.extraSmallElementSpacing) {
            Text("New York City")
            Text("•")
            Text("10 January 2025")
        }
        .foregroundStyle(Color.secondaryText)
        .font(.caption2)
    }
    
    var userIcon: some View {
        Circle()
            .frame(width: 25, height: 25)
            .foregroundStyle(Color.secondaryText)
    }
}

// MARK: - Footer
private extension CommentCell {
    
    var footer: some View {
        HStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
            Spacer()
            replyButton
            upVoteButton
            downVoteButton
        }
        .font(.footnote)
        .foregroundStyle(Color.secondaryText)
    }
    
    var replyButton: some View {
        Button {
            // TODO: ...
        } label: {
            Label {
                Text("Reply")
            } icon: {
                Image(systemName: SystemImage.arrowshapeTurnUpLeft.rawValue)
            }
        }
    }
    
    var upVoteButton: some View {
        Button {
            // TODO: ...
        } label: {
            HStack(alignment: .center, spacing: ViewConstants.extraSmallElementSpacing) {
                Image(systemName: SystemImage.arrowshapeUp.rawValue)
                Text("329")
            }
        }
    }
    
    var downVoteButton: some View {
        Button {
            // TODO: ...
        } label: {
            HStack(alignment: .center, spacing: ViewConstants.extraSmallElementSpacing) {
                Image(systemName: SystemImage.arrowshapeDown.rawValue)
                Text("329")
            }
        }
    }
}
