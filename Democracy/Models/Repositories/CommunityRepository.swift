//
//  CommunityRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/28/24.
//

import Factory
import Foundation

protocol CommunityRepository {
    func submitCommunity(_ community: CommunityCreationRequest) async throws
    func isCommunityNameAvailable(_ name: String) async throws -> Bool
    func fetchAllCommunities() async throws -> [Community]
}

final class CommunityRepositoryDefault: CommunityRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func submitCommunity(_ community: CommunityCreationRequest) async throws {
        try await appwriteService.submitCommunity(community)
    }
    
    func isCommunityNameAvailable(_ name: String) async throws -> Bool {
        try await appwriteService.isCommunityNameAvailable(name)
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        try await appwriteService.fetchAllCommunities()
    }
}
