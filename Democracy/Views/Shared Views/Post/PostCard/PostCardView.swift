//
//  PostCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import SwiftUI

//TODO: Add share button.
//  Add profile picture
// Add upload button.
// Differnt images for community post vs global post.

struct PostCardView<ViewModel: PostCardViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.dateTitle)")
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
                    Text(viewModel.post.subtitle ?? "")
                }
                Spacer()
            }
            Spacer()
            
            HStack {
                
                Text("Tags: ")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.post.tags) { tag in
                            Text(tag.name)
                        }
                    }
                }
            }
            
            HStack {
                
                
                Spacer()
                Image(systemName: "square.and.arrow.up")
                Image(systemName: "arrow.down")
                Text("\(viewModel.post.dislikeCount)")
                Image(systemName: "arrow.up")
                Text("\(viewModel.post.likeCount)")
                Image(systemName: "heart")
                Text("\(viewModel.post.superLikeCount)")
            }
        }
        .onTapGesture {
            viewModel.goToPostView()
        }

        .foregroundColor(.white)
        .padding(15)
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        .frame(maxHeight: 125)
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            PostCardView(viewModel: PostCardViewModel.preview)
        }
        
    }
}
