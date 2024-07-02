//
//  PostHeaderViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/28/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostHeaderViewModel {
    let post: Post
    var linkProviderViewModel: LinkProviderViewModel?
    @ObservationIgnored @Injected(\.voteService) private var voteService
    
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
        post.upVoteCount
    }
    
    var downVoteCount: Int {
        post.downVoteCount
    }
    
    var commentsText: String {
        "\(post.commentCount) comments"
    }
}

// MARK: - Methods
extension PostHeaderViewModel {
    func onTapShareButton() {
        
    }
    
    func onTapVoteButton(_ vote: VoteType) {
        Task {
            do {
                try await voteService.voteOnObject(post, vote: vote)
            } catch {
                print(error)
                print()
            }
        }
    }
}
