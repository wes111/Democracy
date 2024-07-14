//
//  VotingTabCoordinator+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension VotingTabCoordinator {
    @MainActor static let preview = VotingTabCoordinator(viewModel: VotingTabCoordinatorViewModel.preview)
}

extension VotingTabCoordinatorViewModel {
    static let preview: VotingTabCoordinatorViewModel = .init()
}
