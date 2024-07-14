//
//  HistoryTabCoordinator+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension HistoryTabCoordinator {
    @MainActor static let preview = HistoryTabCoordinator(viewModel: .preview)
}

extension HistoryTabCoordinatorViewModel {
    static let preview = HistoryTabCoordinatorViewModel()
}
