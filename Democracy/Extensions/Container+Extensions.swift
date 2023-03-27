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
    
    var postLocalRepository: Factory<PostLocalRepositoryProtocol> {
         self { PostLocalRepository() }
    }
    var postRemoteRepository: Factory<PostRemoteRepositoryProtocol> {
         self { PostRemoteRepository() }
    }
    var userLocalRepository: Factory<UserLocalRepositoryProtocol> {
         self { UserLocalRepository() }
    }
    var userRemoteRepository: Factory<UserRemoteRepositoryProtocol> {
         self { UserRemoteRepository() }
    }
    var communityLocalRepository: Factory<CommunityLocalRepositoryProtocol> {
         self { CommunityLocalRepository() }
    }
    var communityRemoteRepository: Factory<CommunityRemoteRepositoryProtocol> {
         self { CommunityRemoteRepository() }
    }
    var candidateLocalRepository: Factory<CandidateLocalRepositoryProtocol> {
         self { CandidateLocalRepository() }
    }
    var candidateRemoteRepository: Factory<CandidateRemoteRepositoryProtocol> {
         self { CandidateRemoteRepository() }
    }
    
    // MARK: - Services
    var grdbService: Factory<GRDBServiceProtocol> {
         self { GRDBService() }
    }
}
