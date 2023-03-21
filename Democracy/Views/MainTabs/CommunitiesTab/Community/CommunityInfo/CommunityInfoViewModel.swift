//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

protocol CommunityInfoCoordinatorDelegate {
    func showCandidates()
}

protocol CommunityInfoViewModelProtocol: ObservableObject {

    func showCandidates()
}

final class CommunityInfoViewModel: CommunityInfoViewModelProtocol {
    
    let coordinator: CommunityInfoCoordinatorDelegate
    
    init(coordinator: CommunityInfoCoordinatorDelegate
    ) {
        self.coordinator = coordinator
    }
    
    func showCandidates() {
        coordinator.showCandidates()
    }
    
}
