//
//  CandidatesViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

extension CandidatesViewModel {
    @MainActor static let preview = CandidatesViewModel(coordinator: CommunitiesCoordinator.preview)
}
