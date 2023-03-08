//
//  PostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

import SwiftUI

struct PostView<ViewModel: PostViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            
        }
    }
    
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(title: "Post Title", body: "This is the post's body")
        let coordinator = PostCoordinator(post)
        let viewModel = PostViewModel(coordinator: coordinator, post: post)
        PostView(viewModel: viewModel)
    }
}
