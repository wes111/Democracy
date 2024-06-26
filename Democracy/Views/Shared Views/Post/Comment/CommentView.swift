//
//  CommentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import SwiftUI
import Factory
import SharedResourcesClientAndServer

@MainActor
protocol CommentViewModelDelegate: AnyObject {
    func onTapCommentReply(comment: CommentNode)
}

@MainActor @Observable
final class CommentViewModel {
    let commentNode: CommentNode
    private var currentVote: VoteType?
    
    @ObservationIgnored @Injected(\.commentService) private var commentService
    @ObservationIgnored weak var delegate: CommentViewModelDelegate?
    
    var comment: Comment {
        commentNode.value
    }
    
    init(commentNode: CommentNode) {
        self.commentNode = commentNode
    }
    
    // TODO: Need to persist locally upvotes/downvotes....
    // Leaving this comment here, because the postViewModel should have a dictionary of
    // up/down votes for all comments...
    // Current vote will be fetched from local storage on init.
    func didTapVoteButton(_ vote: VoteType) {
        Task {
            do {
                try await commentService.voteOnComment(comment, vote: vote)
            } catch {
                print(error)
                print()
            }
        }
    }
    
    func didTapMenuButton() {
        
    }
    
    func didTapReplyButton() {
        delegate?.onTapCommentReply(comment: commentNode)
    }
    
    var content: String {
        comment.content
    }
    
    var username: String {
        comment.userId
    }
    
    var userTagline: String {
        "New York City"
    }
    
    var loadRepliesTitle: String {
        "Load \(commentNode.value.responseCount)+ Replies"
    }
    
    var date: String {
        comment.creationDate.getFormattedDate(format: .ddMMMyyyy)
    }
    
    var upVoteCount: Int {
        comment.upVoteCount
    }
    
    var downVoteCount: Int {
        comment.downVoteCount
    }
    
    init(comment: CommentNode, delegate: CommentViewModelDelegate?) {
        self.commentNode = comment
        self.delegate = delegate
    }
}

@MainActor
struct CommentView: View {
    @Bindable var viewModel: CommentViewModel
    
    var body: some View {
        primaryContent
    }
}

// MARK: - Subviews
private extension CommentView {
    
    var primaryContent: some View {
        HStack {
            ForEach(0..<viewModel.commentNode.depth, id: \.self) { _ in
                Divider()
                    .overlay(Color.tertiaryText)
                    .padding(.trailing, ViewConstants.smallInnerBorder)
            }
            
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                header
                commentText
                footer
            }
            .padding(.vertical, ViewConstants.smallElementSpacing)
        }
    }
    
    var commentText: some View {
        Text(viewModel.content)
            .foregroundStyle(Color.secondaryText)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - Header
private extension CommentView {
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
        HStack(spacing: ViewConstants.elementSpacing) {
            Text(viewModel.username)
            Spacer()
            replyButton
            menuButton
        }
        .foregroundStyle(Color.secondaryText)
        .font(.caption2)
    }
    
    var headerBottomLine: some View {
        HStack(alignment: .center, spacing: ViewConstants.extraSmallElementSpacing) {
            Text(viewModel.userTagline)
            Text("•")
            Text(viewModel.date)
        }
        .foregroundStyle(Color.secondaryText)
        .font(.caption2)
    }
    
    var userIcon: some View {
        Circle()
            .frame(width: 25, height: 25)
            .foregroundStyle(Color.secondaryText)
    }
    
    var replyButton: some View {
        Button {
            viewModel.didTapReplyButton()
        } label: {
            Label {
                Text("Reply")
            } icon: {
                Image(systemName: SystemImage.arrowshapeTurnUpLeft.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
        /*
         Hack: `.buttonStyle(.plain)` prevents the disclosure group from expanding/collapsing.
         Read more here: https://stackoverflow.com/questions/56561064/swiftui-multiple-buttons-in-a-list-row
         */
    }
    
    var menuButton: some View {
        Button {
            viewModel.didTapMenuButton()
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Footer
private extension CommentView {
    
    var footer: some View {
        HStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
            upVoteButton
            downVoteButton
            Spacer()
        }
        .font(.footnote)
        .foregroundStyle(Color.secondaryText)
    }
    
    var upVoteButton: some View {
        Button(action: { viewModel.didTapVoteButton(.up) }) {
            Label {
                Text("\(viewModel.upVoteCount)")
            } icon: {
                Image(systemName: SystemImage.arrowshapeUp.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
    }
    
    var downVoteButton: some View {
        Button(action: { viewModel.didTapVoteButton(.down) }) {
            Label {
                Text("\(viewModel.downVoteCount)")
            } icon: {
                Image(systemName: SystemImage.arrowshapeDown.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        CommentView(viewModel: .preview)
            .padding()
    }
}
