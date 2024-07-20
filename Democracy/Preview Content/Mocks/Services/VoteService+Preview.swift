//
//  VoteService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

final class VoteServiceMock: VoteService {

}

// MARK: - Methods
extension VoteServiceMock {
    func voteOnObject<T>(_ object: T, vote: VoteType) async throws -> T.Vote where T: Votable {
        .createTempVote()
    }
}
