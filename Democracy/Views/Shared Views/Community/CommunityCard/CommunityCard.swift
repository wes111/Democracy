//
//  CommunityCard.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/3/24.
//

import SwiftUI

@MainActor
struct CommunityCard: View {
    @State private var viewModel: CommunityCardViewModel
    
    init(viewModel: CommunityCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension CommunityCard {
    
    var content: some View {
        Button {
            viewModel.onTap()
        } label: {
            buttonContent
        }
        .buttonStyle(.plain)
    }
    
    var buttonContent: some View {
        HStack(alignment: .top) {
            communityImage
            
            VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
                communityName
                communityTagline
            }
            
            Spacer()
            joinLeaveButton
        }
    }
    
    var communityImage: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(Color.secondaryText)
    }
    
    var communityName: some View {
        Text(viewModel.name)
            .foregroundStyle(Color.secondaryText)
            .font(.subheadline)
            .fontWeight(.bold)
    }
    
    var communityTagline: some View {
        Text(viewModel.tagline)
            .foregroundStyle(Color.secondaryText)
            .font(.caption2)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }
    
    var joinLeaveButton: some View { // TODO: This view needs to be abstracted...
        NewAsyncButton {
            await viewModel.toggleCommunityMembership()
        } label: {
            Text(viewModel.membershipButtonTitle)
        }
        .buttonStyle(ExtraSmallSecondaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        CommunityCard(viewModel: CommunityCardViewModel.preview)
    }
}
