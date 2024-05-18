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
    var currentValue: [Membership] { get async }
    
    func fetchMemberships(refresh: Bool) async throws
    func joinCommunity(_ community: Community) async throws
    func leaveCommunity(membership: Membership) async throws
    func membershipsStream() async -> AsyncStream<[Membership]>
}

final class MembershipServiceDefault: MembershipService {
    @Injected(\.membershipRepository) private var membershipRepository
    @Injected(\.userRepository) private var userRepository
    
    var currentValue: [Membership] {
        get async {
            return await membershipRepository.currentValue
        }
    }
    
    func fetchMemberships(refresh: Bool) async throws {
        try await membershipRepository.fetchUserMemberships(
            userId: try await userRepository.userId(),
            refresh: refresh
        )
    }
    
    func membershipsStream() async -> AsyncStream<[Membership]> {
        await membershipRepository.values()
    }
    
    func joinCommunity(_ community: Community) async throws {
        try await membershipRepository.joinCommunity(.init(
            userId: try await userRepository.userId(),
            communityId: community.id
        ))
    }
    
    func leaveCommunity(membership: Membership) async throws {
        try await membershipRepository.leaveCommunity(membership)
    }
}
