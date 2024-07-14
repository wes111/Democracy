//
//  UpdatesTabCoordinator+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension UpdatesTabCoordinator {
    @MainActor static let preview = UpdatesTabCoordinator(viewModel: .preview)
}

extension UpdatesTabCoordinatorViewModel {
    static let preview = UpdatesTabCoordinatorViewModel()
}
