//
//  MembershipService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

final class MembershipServiceMock: MembershipService {
    let currentValue: [Membership] = []
}

// MARK: - Methods
extension MembershipServiceMock {
    
    func fetchMemberships(refresh: Bool) async throws {
        return
    }
    
    func joinCommunity(_ community: Community) async throws {
        return
    }
    
    func leaveCommunity(membership: Membership) async throws {
        return
    }
    
    func membershipsStream() async -> AsyncStream<[Membership]> {
        .init { _ in }
    }
}
