//
//  MembershipService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Factory
import Foundation

enum MembershipServiceError: Error {
    case userAccountMissing
}

protocol MembershipService: Sendable {
    func userMemberships() async throws -> [Membership]
    func joinCommunity(_ community: Community) async throws
    func leaveCommunity(membership: Membership) async throws
}

final class MembershipServiceDefault: MembershipService {
    @Injected(\.membershipRepository) private var membershipRepository
    @Injected(\.userRepository) private var userRepository
    
    func userMemberships() async throws -> [Membership] {
        guard let userId = await userRepository.currentValue?.id else {
            throw MembershipServiceError.userAccountMissing
        }
        return try await membershipRepository.fetchUserMemberships(userId: userId)
    }
    
    func joinCommunity(_ community: Community) async throws {
        guard let userId = await userRepository.currentValue?.id else {
            throw MembershipServiceError.userAccountMissing
        }
        try await membershipRepository.joinCommunity(.init(userId: userId, communityId: community.id))
    }
    
    func leaveCommunity(membership: Membership) async throws {
        guard let userId = await userRepository.currentValue?.id else {
            throw MembershipServiceError.userAccountMissing
        }
        try await membershipRepository.leaveCommunity(membership)
    }
}
