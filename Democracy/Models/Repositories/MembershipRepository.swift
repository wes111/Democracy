//
//  MembershipRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Factory
import Foundation

protocol MembershipRepository {
    func fetchUserMemberships(userId: String, refresh: Bool) async throws // -> [Membership]
    func joinCommunity(_ membership: MembershipCreationRequest) async throws
    func leaveCommunity(_ membership: Membership) async throws
    func values() async -> AsyncStream<[Membership]>
}

actor MembershipRepositoryDefault: MembershipRepository, Streamable {
    
    @Injected(\.appwriteService) private var appwriteService
    let createMembershipDataHandler = DataProvider.shared.membershipDataHandlerCreator()
    var continuations: [UUID: AsyncStream<[Membership]>.Continuation] = [:]
    
    func fetchUserMemberships(userId: String, refresh: Bool) async throws {
        if refresh {
            let memberships = try await appwriteService.fetchUserMemberships(userId: userId)
            try await createMembershipDataHandler().replaceAll(newMemberships: memberships)
            send(memberships)
        } else {
            let memberships = try await createMembershipDataHandler().fetchPersistedMemberships()
            send(memberships)
        }
    }
    
    func joinCommunity(_ membership: MembershipCreationRequest) async throws {
        try await appwriteService.joinCommunity(membership)
    }
    
    func leaveCommunity(_ membership: Membership) async throws {
        try await appwriteService.leaveCommunity(membership)
    }
}
