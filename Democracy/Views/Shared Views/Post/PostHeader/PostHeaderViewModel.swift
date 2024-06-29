//
//  PostHeaderViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/28/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostHeaderViewModel {
    let post: Post
    var linkProviderViewModel: LinkProviderViewModel?
    
    init(post: Post) {
        self.post = post
        
        if let url = post.link {
            linkProviderViewModel = LinkProviderViewModel(url)
        }
    }
}

// MARK: - Computed Properties
extension PostHeaderViewModel {
    var date: String {
        post.creationDate.getFormattedDate(format: .ddMMMyyyy)
    }
    
    var upVoteCount: Int {
        0
    }
    
    var downVoteCount: Int {
        0
    }
}

// MARK: - Methods
extension PostHeaderViewModel {
    func onTapShareButton() {
        
    }
    
    func onTapVoteButton(_ vote: VoteType) {
        
    }
}
