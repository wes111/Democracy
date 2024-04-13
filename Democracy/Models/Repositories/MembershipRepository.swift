//
//  MembershipRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Factory
import Foundation

protocol MembershipRepository {
    var currentValue: [Membership] { get async }
    
    func fetchUserMemberships(userId: String, refresh: Bool) async throws // -> [Membership]
    func joinCommunity(_ membership: MembershipCreationRequest) async throws
    func leaveCommunity(_ membership: Membership) async throws
    func values() async -> AsyncStream<[Membership]>
}

actor MembershipRepositoryDefault: MembershipRepository, Streamable {
    
    @Injected(\.appwriteService) private var appwriteService
    let createMembershipDataHandler = DataProvider.shared.membershipDataHandlerCreator()
    var continuations: [UUID: AsyncStream<[Membership]>.Continuation] = [:]
    
    var currentValue: [Membership] = []
    
    init() {
        Task {
            try await initCurrentValue()
        }
    }
    
    func initCurrentValue() async throws {
        currentValue = try await createMembershipDataHandler().fetchPersistedMemberships()
    }
    
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
        let newMembership = try await appwriteService.joinCommunity(membership)
        try await createMembershipDataHandler().insertNewMembershipData(domainModel: newMembership)
        var memberships = currentValue
        memberships.append(newMembership)
        send(memberships)
    }
    
    func leaveCommunity(_ membership: Membership) async throws {
        try await appwriteService.leaveCommunity(membership)
        try await createMembershipDataHandler().newDelete(model: membership)
        var memberships = currentValue
        memberships.removeAll(where: { $0.id == membership.id })
        send(memberships)
    }
}
