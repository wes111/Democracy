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
            
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.post.title)
                        .font(.title)
                    Text(viewModel.post.subtitle ?? "")
                        .lineLimit(3)
                }
                Spacer()
            }
            
            HStack(spacing: 15) {
                
                Label("\(viewModel.post.superLikeCount)", systemImage: "heart")
                Image(systemName: "square.and.arrow.up")
                
                Spacer()
                Label("\(viewModel.post.dislikeCount)", systemImage: "arrow.down")
                Label("\(viewModel.post.likeCount)", systemImage: "arrow.up")
                
            }
            .labelStyle(TightLabelStyle())
        }
        .onTapGesture {
            viewModel.goToPostView()
        }
        
        .foregroundColor(.white)
        .padding(20)
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
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
