//
//  CommunityRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/28/24.
//

import Factory
import Foundation

protocol CommunityRepository {
    func submitCommunity(_ community: CommunityDTO) async throws
}

final class CommunityRepositoryDefault: CommunityRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func submitCommunity(_ community: CommunityDTO) async throws {
        try await appwriteService.submitCommunity(community)
    }
}
