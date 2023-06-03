//
//  PostCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Foundation

protocol PostCardCoordinatorDelegate {
    func goToPostView(_ post: Post)
}

protocol PostCardViewModelProtocol: ObservableObject {
    var post: Post { get }
    var imageName: String { get }
    var dateTitle: String { get }
    func goToPostView()
    func noAction()
}

final class PostCardViewModel: PostCardViewModelProtocol {
    
    private let coordinator: PostCardCoordinatorDelegate
    let post: Post
    
    var imageName: String {
        // if postLocationInApp == global vs in community
        return post.creator.imageName ?? "bernie" // default image.
    }
    
    var dateTitle: String {
        if post.creationDate.isYesterday() {
            return "Yesterday"
        } else if post.creationDate.isToday() {
            return "Today"
        } else {
            return post.creationDate.getFormattedDate(format: "MMMM dd, YYYY")
        }
        
    }
    
    init(coordinator: PostCardCoordinatorDelegate,
         post: Post
    ) {
        self.coordinator = coordinator
        self.post = post
    }
    
    func goToPostView() {
        coordinator.goToPostView(post)
    }
    
    func noAction() {
        print("No Action.")
    }
    
}
