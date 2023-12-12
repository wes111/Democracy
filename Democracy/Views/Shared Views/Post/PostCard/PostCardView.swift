//
//  PostCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import SwiftUI

struct PostCardView: View {
    
    @StateObject private var viewModel: PostCardViewModel
    
    init(viewModel: PostCardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            header
                .padding(.horizontal, 10)
            
            content
            
            footer
            
        }
        .foregroundColor(.primaryText)
        .padding(.vertical, 20)
        .background(Color.secondaryBackground)
        .background(Rectangle())
        .font(.body)
        .lineLimit(1)
        .onTapGesture {
            viewModel.goToPostView()
        }
        .task {
            await viewModel.loadLinkMetadata()
        }
    }
    
    var header: some View {
        HStack(alignment: .top) {
            
            Image(viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(height: 50)
            
            VStack(alignment: .leading) {
                Text(viewModel.postNameOrCommunity)
                Text(viewModel.dateTitle)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
            
            Spacer()
            
            Menu {
                Button("Order Now", action: viewModel.noAction)
                Button("Adjust Order", action: viewModel.noAction)
                Button("Cancel", action: viewModel.noAction)
            } label: {
                Image(systemName: "ellipsis")
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(viewModel.postTitle)
                        .font(.title)
                    
                    if let subtitle = viewModel.postSubtitle {
                        Text(subtitle)
                            .lineLimit(3)
                            .foregroundColor(.secondaryText)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            
            if let metadata = viewModel.linkMetadata {
                LPLinkViewRepresented(metadata: metadata)
            }
        }
    }
    
    var footer: some View {
        HStack(spacing: 15) {
            
            Label(viewModel.postSuperLikeCountString, systemImage: "heart")
            Image(systemName: "square.and.arrow.up")
            Spacer()
            Label(viewModel.postDislikeCountString, systemImage: "arrow.down")
            Label(viewModel.postLikeCountString, systemImage: "arrow.up")
        }
        .labelStyle(TightLabelStyle())
        .padding(.horizontal, 10)
    }
        
}

// MARK: - Preview
#Preview {
    ScrollView {
        PostCardView(viewModel: PostCardViewModel.preview)
    }.background(
        Color.primaryBackground
    )
}
