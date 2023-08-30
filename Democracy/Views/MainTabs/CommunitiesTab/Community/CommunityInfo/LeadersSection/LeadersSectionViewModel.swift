//
//  LeadersSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation

struct LeadersSectionViewModel {
    
    let creatorsScrollViewModel: LeadersScrollViewModel
    let modsScrollViewModel: LeadersScrollViewModel
    let legislatorsScrollViewModel: LeadersScrollViewModel
    
    let coordinator: LeadersScrollViewModelCoordinatorDelegate
    
    init(creators: [Candidate], mods: [Candidate], legislators: [Candidate], coordinator: LeadersScrollViewModelCoordinatorDelegate) {
        self.coordinator = coordinator
        
        creatorsScrollViewModel = .init(candidates: creators, repType: .creator, coordinator: coordinator)
        modsScrollViewModel = .init(candidates: mods, repType: .mod, coordinator: coordinator)
        legislatorsScrollViewModel = .init(candidates: legislators, repType: .legislator, coordinator: coordinator)
    }
    
    func tappedVote() {
        coordinator.goToVoteView()
    }
    
}
