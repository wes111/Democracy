//
//  CreateCandidateViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/27/23.
//

import Foundation

extension CreateCandidateViewModel {
    
    class PreviewHelper: CreateCandidateCoordinatorDelegate {
        func closeCreateCandidateView() {
            // TODO: ...
        }
    }
    
    static let preview = CreateCandidateViewModel(coordinator: PreviewHelper())
}
