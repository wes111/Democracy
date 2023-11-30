//
//  PostCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

import SwiftUI

enum PostPath {
    case one
}

struct PostCoordinator: View {
    
    private let post: Post
    
    init(_ post: Post) {
        self.post = post
    }
    
    var body: some View {
        createPostView()
            .navigationDestination(for: PostPath.self) { path in
                createViewFromPath(path)
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: PostPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    @MainActor
    func createPostView() -> PostView<PostViewModel> {
        let viewModel = PostViewModel(post: post)
        return PostView(viewModel: viewModel)
    }
}

// MARK: - Preview
#Preview {
    PostCoordinator(Post.preview)
}
