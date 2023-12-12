//
//  CandidateViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

extension CandidateViewModel {
    static let preview = CandidateViewModel(
        coordinator: CommunityCoordinator.preview,
        candidate: Candidate.preview
    )
}
