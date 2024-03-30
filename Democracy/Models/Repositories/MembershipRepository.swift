//
//  MembershipRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Foundation

import Factory
import Foundation

protocol MembershipRepository {
    func fetchUserMemberships(userId: String) async throws -> [Membership]
    func joinCommunity(_ membership: MembershipCreationRequest) async throws
    func leaveCommunity(_ membership: Membership) async throws
}

final class MembershipRepositoryDefault: MembershipRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func fetchUserMemberships(userId: String) async throws -> [Membership] {
        try await appwriteService.fetchUserMemberships(userId: userId)
    }
    
    func joinCommunity(_ membership: MembershipCreationRequest) async throws {
        try await appwriteService.joinCommunity(membership)
    }
    
    func leaveCommunity(_ membership: Membership) async throws {
        try await appwriteService.leaveCommunity(membership)
    }
}
