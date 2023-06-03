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
            .padding(.horizontal, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.postTitle)
                        .font(.title)
                    if let subtitle = viewModel.postSubtitle {
                        Text(subtitle)
                            .lineLimit(3)
                    }
                    
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            
            if let metadata = viewModel.linkMetadata {
                LPLinkViewRepresented(metadata: metadata)
            }
            
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
        .onTapGesture {
            viewModel.goToPostView()
        }
        .foregroundColor(.white)
        .padding(.vertical, 20)
        //.padding(20)
        .background(Rectangle())
        .font(.body)
        .lineLimit(1)
    }
        
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            ScrollView {
                Spacer()
                    .frame(height: 25)
                PostCardView(viewModel: PostCardViewModel.preview)
            }
        }
    }
}
