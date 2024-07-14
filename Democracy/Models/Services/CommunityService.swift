//
//  CommunityService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/28/24.
//

import Factory
import Foundation

enum CommunityServiceError: Error {
    case invalidUserInput
}

protocol CommunityService: Sendable {
    func submitCommunity(userInput: SubmitCommunityInput) async throws
    func isCommunityNameAvailable(_ name: String) async throws -> Bool
    func fetchAllCommunities() async throws -> [Community]
}

final class CommunityServiceDefault: CommunityService {
    @Injected(\.communityRepository) private var communityRepository
    @Injected(\.userRepository) private var userRepository
    
    func submitCommunity(userInput: SubmitCommunityInput) async throws {
        guard let name = userInput.name, let description = userInput.description, let tagline = userInput.tagline,
              !userInput.categories.isEmpty, !userInput.tags.isEmpty, !userInput.rules.isEmpty
        else {
            throw CommunityServiceError.invalidUserInput
        }
        
        try await communityRepository.submitCommunity(.init(
            creatorId: try await userRepository.userId(),
            name: name,
            descriptionText: description,
            rules: Array(userInput.rules).map { $0.toCreationRequest() },
            resources: userInput.resources.map { $0.toCreationRequest() },
            postCategories: userInput.categories,
            tags: Array(userInput.tags),
            tagline: tagline,
            settings: userInput.settings
        ))
    }
    
    func isCommunityNameAvailable(_ name: String) async throws -> Bool {
        try await communityRepository.isCommunityNameAvailable(name)
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        try await communityRepository.fetchAllCommunities()
    }
}
