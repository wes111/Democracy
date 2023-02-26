//
//  CommunitiesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol CommunitiesTabMainCoordinatorDelegate {
    func goToCommunity(_ community: Community)
}

protocol CommunitiesTabMainViewModelProtocol: ObservableObject {
    var communities: [Community] { get }
    func goToCommunity(_ community: Community)
    func refreshCommunities()
}

final class CommunitiesTabMainViewModel: CommunitiesTabMainViewModelProtocol {
    
    @Published var communities: [Community] = [
        Community(name: "Test Community 1", foundedDate: Date()),
        Community(name: "Test Community 2", foundedDate: Date()),
        Community(name: "Test Community 3", foundedDate: Date()),
        Community(name: "Test Community 4", foundedDate: Date()),
    ]

    var coordinator: CommunitiesTabMainCoordinatorDelegate
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func goToCommunity(_ community: Community) {
        coordinator.goToCommunity(community)
    }
    
    func refreshCommunities() {
        // TODO: 
    }
    
}
