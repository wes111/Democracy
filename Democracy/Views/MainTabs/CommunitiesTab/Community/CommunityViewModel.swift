//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

protocol CommunityCoordinatorDelegate {
    func go()
}

protocol CommunityViewModelProtocol: ObservableObject {
    var community: Community { get }
    func go()
}

final class CommunityViewModel: CommunityViewModelProtocol {

    private let coordinator: CommunityCoordinatorDelegate
    let community: Community
    
    init(coordinator: CommunityCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    func go() {
        coordinator.go()
    }
    
}
