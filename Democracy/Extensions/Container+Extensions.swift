//
//  Container+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import Foundation
import Factory

extension Container {
    // MARK: - Services
    
    var appwriteService: Factory<AppwriteService> {
        self { AppwriteServiceDefault() }
    }
    
    var richLinkService: Factory<RichLinkServiceProtocol> {
        self { RichLinkService() } 
    }
    
    var accountService: Factory<AccountService> {
        self { AccountServiceDefault() }.scope(.shared)
    }
    
    var postService: Factory<PostService> {
        self { PostServiceDefault() }.scope(.shared)
    }
    
    var communityService: Factory<CommunityService> {
        self { CommunityServiceDefault() }.scope(.shared)
    }
    
    var membershipService: Factory<MembershipService> {
        self { MembershipServiceDefault() }.scope(.shared)
    }
    
    var commentService: Factory<CommentService> {
        self { CommentServiceDefault() }.scope(.shared)
    }
    
    var voteService: Factory<VoteService> {
        self { VoteServiceDefault() }.scope(.shared)
    }
    
    var passwordLocalRepository: Factory<PasswordRepository> {
        self { PasswordRepositoryDefault() }.scope(.shared)
    }
    
    // MARK: - Repositories
    
    var userRepository: Factory<any UserRepository> {
        self { UserRepositoryDefault() }.scope(.shared)
    }
    
    var sessionRepository: Factory<any SessionRepository> {
        self { SessionRepositoryDefault() }.scope(.shared)
    }
    
    var postRepository: Factory<PostRepository> {
        self { PostRepositoryDefault() }.scope(.shared)
    }
    
    var communityRepository: Factory<CommunityRepository> {
        self { CommunityRepositoryDefault() }.scope(.shared)
    }
    
    var membershipRepository: Factory<MembershipRepository> {
        self { MembershipRepositoryDefault() }.scope(.shared)
    }
    
    var commentRepository: Factory<CommentRepository> {
        self { CommentRepositoryDefault() }.scope(.shared)
    }
    
    var voteRepository: Factory<VoteRepository> {
        self { VoteRepositoryDefault() }.scope(.shared)
    }
}
