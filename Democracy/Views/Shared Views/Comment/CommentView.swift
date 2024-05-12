//
//  CommentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import SwiftUI

@MainActor @Observable
final class CommentViewModel {
    private let comment: Comment
    
    func didTapReplyButton() {
        
    }
    
    func didTapUpVoteButton() {
        
    }
    
    func didTapDownVoteButton() {
        
    }
    
    func didTapMenuButton() {
        
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
    
    var date: String {
        comment.creationDate.getFormattedDate(format: .ddMMMyyyy)
    }
    
    var upVoteCount: Int
    var downVoteCount: Int
    
    init(comment: Comment) {
        self.comment = comment
        upVoteCount = comment.upVoteCount
        downVoteCount = comment.downVoteCount
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
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            header
            commentText
            footer
        }
    }
    
    var commentText: some View {
        Text(viewModel.content)
            .foregroundStyle(Color.secondaryText)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
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
        HStack {
            Text(viewModel.username)
            Spacer()
            Image(systemName: SystemImage.ellipsis.rawValue)
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
}

// MARK: - Footer
private extension CommentView {
    
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
        Button(action: viewModel.didTapReplyButton) {
            Label {
                Text("Reply")
            } icon: {
                Image(systemName: SystemImage.arrowshapeTurnUpLeft.rawValue)
            }
        }
    }
    
    var upVoteButton: some View {
        Button(action: viewModel.didTapUpVoteButton) {
            HStack(alignment: .center, spacing: ViewConstants.extraSmallElementSpacing) {
                Image(systemName: SystemImage.arrowshapeUp.rawValue)
                Text("\(viewModel.upVoteCount)")
            }
        }
    }
    
    var downVoteButton: some View {
        Button(action: viewModel.didTapDownVoteButton) {
            HStack(alignment: .center, spacing: ViewConstants.extraSmallElementSpacing) {
                Image(systemName: SystemImage.arrowshapeDown.rawValue)
                Text("\(viewModel.downVoteCount)")
            }
        }
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
