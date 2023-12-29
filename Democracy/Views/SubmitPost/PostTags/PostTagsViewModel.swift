//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

final class PostTagsViewModel: ObservableObject, Hashable {
    weak var coordinator: SubmitPostCoordinatorDelegate?
    private let submitPostInput: SubmitPostInput
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
}
