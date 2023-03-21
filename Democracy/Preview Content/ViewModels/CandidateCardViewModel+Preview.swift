//
//  CandidateCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

extension CandidateCardViewModel {
    
    static let preview = CandidateCardViewModel(
        coordinator: CommunityCoordinator.preview,
        candidate: Candidate.preview
    )
}
