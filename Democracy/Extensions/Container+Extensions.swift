//
//  Container+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import Foundation
import Factory

extension Container {
    
    // MARK: - Interactors
    var postInteractor: Factory<PostInteractorProtocol> {
         self { PostInteractor() }
    }
    var candidateInteractor: Factory<CandidateInteractorProtocol> {
         self { CandidateInteractor() }
    }
    var communityInteractor: Factory<CommunityInteractorProtocol> {
        self { CommunityInteractor() }
    }
    
    // MARK: - Repositories
    // TODO: Get rid of these repositories!
    var postLocalRepository: Factory<PostLocalRepositoryProtocol> {
         self { PostLocalRepository() }
    }
    
    var communityLocalRepository: Factory<CommunityLocalRepositoryProtocol> {
         self { CommunityLocalRepository() }
    }
    
    var candidateLocalRepository: Factory<CandidateLocalRepositoryProtocol> {
         self { CandidateLocalRepository() }
    }
    
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
    
    var passwordLocalRepository: Factory<PasswordRepository> {
        self { PasswordRepositoryDefault() }.scope(.shared)
    }
    
    // MARK: - New Repositories
    
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
}
