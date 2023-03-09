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
                Spacer()
                Text("Post Card view")
                    .onTapGesture {
                        viewModel.goToPostView(Post(title: "TEst title", body: "Test body"))
                    }
                Spacer()
            }
        }
        .foregroundColor(.white)
        .padding(10)
        .padding(.bottom, 50)
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(title: "Post Title", body: "Post Body")
        let community = Community(name: "Community Name", foundedDate: Date())
        let router = Router()
        let coordinator = CommunityCoordinator(community, router)
        let viewModel = PostCardViewModel(coordinator: coordinator, post: post)
        PostCardView(viewModel: viewModel)
    }
}
