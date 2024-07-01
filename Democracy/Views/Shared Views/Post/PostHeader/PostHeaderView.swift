//
//  PostHeaderView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/26/24.
//

import SwiftUI

@MainActor
struct PostHeaderView: View {
    @State private var viewModel: PostHeaderViewModel
    
    init(viewModel: PostHeaderViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension PostHeaderView {
    var content: some View {
        VStack(spacing: ViewConstants.elementSpacing) {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                topLineMetadata
                title
                bodyText
                if let linkProviderViewModel = viewModel.linkProviderViewModel {
                    customLink(viewModel: linkProviderViewModel)
                }
                tags
                bottomButtonsRow
            }
            .padding(.horizontal, ViewConstants.screenPadding)
            divider
        }
    }
    
    var topLineMetadata: some View {
        HStack(spacing: ViewConstants.smallElementSpacing) {
            Text(viewModel.post.category)
                .tagModifier(backgroundColor: .otherRed)
            
            VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
                Text(viewModel.post.userId)
                    .foregroundStyle(Color.secondaryText)
                    .font(.footnote)
                
                Text("\(viewModel.date)")
                    .foregroundStyle(Color.secondaryText)
                    .fontWeight(.light)
                    .font(.caption2)
            }
        }
    }
    
    var tags: some View {
        NewFlowLayout(alignment: .leading) {
            ForEach(viewModel.post.tags, id: \.self) { tag in
                Text(tag)
                    .font(.footnote)
                    .tagModifier(backgroundColor: .onBackground)
            }
        }
    }
    
    var title: some View {
        Text(viewModel.post.title)
            .foregroundStyle(Color.primaryText)
            .font(.title3)
            .fontWeight(.bold)
    }
    
    var bodyText: some View {
        Text(viewModel.post.body)
            .foregroundStyle(Color.secondaryText)
            .font(.footnote)
    }
    
    func customLink(viewModel: LinkProviderViewModel) -> some View {
        CustomLinkProviderView(viewModel: viewModel)
            .frame(height: 100)
    }
    
    var divider: some View {
        Divider()
            .overlay(Color.black)
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
        Color.primaryBackground.ignoresSafeArea()
        PostHeaderView(viewModel: .preview)
    }
}
