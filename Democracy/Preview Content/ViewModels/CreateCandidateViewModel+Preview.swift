//
//  CreateCandidateViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/27/23.
//

import Foundation

extension CreateCandidateViewModel {
    @MainActor static let preview = CreateCandidateViewModel(coordinator: CommunitiesCoordinator.preview)
}
