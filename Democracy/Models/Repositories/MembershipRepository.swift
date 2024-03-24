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
}

final class MembershipRepositoryDefault: MembershipRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func fetchUserMemberships(userId: String) async throws -> [Membership] {
        try await appwriteService.fetchUserMemberships(userId: userId)
    }
}
