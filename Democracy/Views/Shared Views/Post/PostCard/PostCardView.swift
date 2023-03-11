//
//  PostCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import SwiftUI

struct PostCardView<ViewModel: PostCardViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.post.creationDate)")
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
                    Text(viewModel.post.subtitle)
                }
                Spacer()
            }
            Spacer()
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.post.tags) { tag in
                            Text(tag.name)
                        }
                    }
                }
                .frame(maxWidth: 250)
                
                Spacer()
                Image(systemName: "arrow.down")
                Image(systemName: "arrow.up")
            }
        }
        .onTapGesture {
            viewModel.goToPostView(viewModel.post)
        }

        .foregroundColor(.white)
        .padding(15)
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        .frame(maxHeight: 125)
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        PostCardView(viewModel: PostCardViewModel.preview)
    }
}
