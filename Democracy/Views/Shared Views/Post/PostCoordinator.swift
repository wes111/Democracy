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
    
    @EnvironmentObject private var router: Router
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
    
    func createPostView() -> PostView<PostViewModel> {
        let viewModel = PostViewModel(coordinator: self, post: post)
        return PostView(viewModel: viewModel)
    }
}

extension PostCoordinator: PostCoordinatorDelegate {
    
    func go() {
        print("go")
    }
    
}

struct PostCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(title: "Post Title", body: "This is the post body.")
        PostCoordinator(post)
    }
}
