//
//  PostCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import SwiftUI

@MainActor
struct PostCardView: View {
    @State private var viewModel: PostCardViewModel
    
    init(viewModel: PostCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension PostCardView {
    
    var content: some View {
        Button {
            viewModel.goToPostView()
        } label: {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                header
                title
                if let linkProviderViewModel = viewModel.linkProviderViewModel {
                    customLink(viewModel: linkProviderViewModel)
                }
                bottomButtonsRow
            }
            .padding(.horizontal, ViewConstants.screenPadding)
            .padding(.vertical, ViewConstants.largeElementSpacing)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    var title: some View {
        Text(viewModel.post.title)
            .foregroundStyle(Color.secondaryText)
            .font(.headline)
            .fontWeight(.semibold)
    }
    
    func customLink(viewModel: LinkProviderViewModel) -> some View {
        CustomLinkProviderView(viewModel: viewModel)
            .frame(height: 75)
    }
    
    var bottomButtonsRow: some View {
        HStack(spacing: 0) {
            commentsCount
            
            VoteButtons(
                didTapVoteButton: viewModel.onTapVoteButton(_:),
                upVoteCount: viewModel.upVoteCount,
                downVoteCount: viewModel.downVoteCount
            )
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
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
    
    var menuButton: some View {
        Button {
            viewModel.onTapMenuButton()
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
        }
        .buttonStyle(.plain)
    }
    
    var commentsCount: some View {
        Label(viewModel.commentsText, systemImage: SystemImage.bubble.rawValue)
            .font(.footnote)
            .foregroundStyle(Color.secondaryText)
            .labelStyle(TightLabelStyle())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground
        PostCardView(viewModel: PostCardViewModel.preview)
    }
}
