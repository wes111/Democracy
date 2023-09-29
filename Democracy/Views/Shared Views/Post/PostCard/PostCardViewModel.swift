//
//  PostCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Factory
import Foundation
import LinkPresentation

protocol PostCardCoordinatorDelegate {
    func goToPostView(_ post: Post)
}

final class PostCardViewModel: ObservableObject, Hashable, Identifiable {
    
    //MARK: - Private Variables
    @Injected(\.richLinkService) private var richLinkService
    private let coordinator: PostCardCoordinatorDelegate
    let post: Post //TODO: Make this private?
    
    // MARK: - Protocol Variables
    @Published var linkMetadata: LPLinkMetadata?

    var imageName: String {
        // if postLocationInApp == global vs in community
        //return post.creator.imageName ?? "bernie" // default image.
        return "bernie"
    }
    
    var postNameOrCommunity: String {
        // if postLocationInApp == global vs in community
        return "Bernie Sanders"
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
    
    var postTitle: String {
        post.title
    }
    
    var postSubtitle: String? {
        post.subtitle
    }
    
    var postSuperLikeCountString: String {
        "\(post.superLikeCount)"
    }
    
    var postLikeCountString: String {
        "\(post.likeCount)"
    }
    
    var postDislikeCountString: String {
        "\(post.dislikeCount)"
    }
    
    // MARK: - Init
    
    init(coordinator: PostCardCoordinatorDelegate,
         post: Post
    ) {
        self.coordinator = coordinator
        self.post = post
    }
    
    // MARK: - Protocol Methods
    
    func goToPostView() {
        coordinator.goToPostView(post)
    }
    
    func noAction() {
        
    }
    
    // MARK: - Private methods
    
    func loadLinkMetadata() async {
        guard let url = post.link?.url else { return }
        do {
            let metadata = try await richLinkService.getMetadata(for: url)
            
            await MainActor.run {
                self.linkMetadata = metadata
            }
        } catch {
            print("Error occurred fetching rich link metadata: \(error).")
        }
    }
    
}
