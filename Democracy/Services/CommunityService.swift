//
//  CommunityService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/28/24.
//

import Factory
import Foundation

enum CommunityServiceError: Error {
    case userAccountMissing
    case invalidUserInput
}

protocol CommunityService {
    func submitCommunity(userInput: SubmitCommunityInput) async throws
    func isCommunityNameAvailable(_ name: String) async throws -> Bool
    func fetchAllCommunities() async throws -> [Community]
}

final class CommunityServiceDefault: CommunityService {
    @Injected(\.communityRepository) private var communityRepository
    @Injected(\.userRepository) private var userRepository
    
    func submitCommunity(userInput: SubmitCommunityInput) async throws {
        guard let userId = await userRepository.currentValue?.id else {
            throw CommunityServiceError.userAccountMissing
        }
        guard let name = userInput.name, let description = userInput.description,
              !userInput.categories.isEmpty, !userInput.tags.isEmpty, !userInput.rules.isEmpty
        else {
            throw CommunityServiceError.invalidUserInput
        }
        
        try await communityRepository.submitCommunity(.init(
            creatorId: userId,
            name: name,
            description: description,
            rules: Array(userInput.rules).map { $0.toCreationRequest() },
            resources: userInput.resources.map { $0.toCreationRequest() },
            categories: Array(userInput.categories),
            tags: Array(userInput.tags),
            governmentType: userInput.settings.government,
            contentType: userInput.settings.content,
            visibilityType: userInput.settings.visibility,
            allowedPosterType: userInput.settings.poster,
            allowedCommenterType: userInput.settings.commenter,
            postApprovalType: userInput.settings.postApproval
        ))
    }
    
    func isCommunityNameAvailable(_ name: String) async throws -> Bool {
        try await communityRepository.isCommunityNameAvailable(name)
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        try await communityRepository.fetchAllCommunities()
    }
}
