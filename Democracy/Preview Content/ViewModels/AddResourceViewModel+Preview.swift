//
//  AddResourceViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import Foundation

extension AddResourceViewModel {
    @MainActor static let preview = AddResourceViewModel(
        resources: [],
        communityName: "CommunityName",
        updateResourcesAction: {_ in },
        cancelEditingAction: {}
    )
}
