//
//  CommunityService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

final class CommunityServiceMock: CommunityService {

}

// MARK: - Methods
extension CommunityServiceMock {
    
    func submitCommunity(userInput: SubmitCommunityInput) async throws {
        return
    }
    
    func isCommunityNameAvailable(_ name: String) async throws -> Bool {
        true
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        []
    }
}
