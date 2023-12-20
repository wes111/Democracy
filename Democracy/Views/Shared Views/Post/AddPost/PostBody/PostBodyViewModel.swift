//
//  PostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

final class PostBodyViewModel: ObservableObject, Hashable {
    weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(coordinator: SubmitPostCoordinatorDelegate) {
        self.coordinator = coordinator
    }
}
