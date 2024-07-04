//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

@MainActor @Observable
final class CommunityInfoViewModel {
    let community: Community
    var isShowingProgress: Bool = false
    weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(coordinator: CommunitiesCoordinatorDelegate?, community: Community) {
        self.coordinator = coordinator
        self.community = community
    }
    
}

// MARK: - Computed Properties
extension CommunityInfoViewModel {
    var description: String {
        community.descriptionText
    }
    
    var alliedCommunities: [Community] {
        Community.myCommunitiesPreviewArray // TODO: ...
    }
    
    var rules: [Rule] {
        community.rules
    }
    
    var resources: [Resource] {
        community.resources
    }
    
    var candidates: [Candidate] { // TODO: This view should have reps, not candidates....
        Candidate.previewArray
    }
    
//    var leaders: [Leader] {
//        [] // TODO: ...
//    }
}

// MARK: - Methods
extension CommunityInfoViewModel {
    
    func showCandidates() {
        coordinator?.showCandidates()
    }
    
    func onTapCommunityCard(_ community: Community) {
        coordinator?.goToCommunity(community: community)
    }
    
    func onTapCandidateCard(candidateID: String) {
        coordinator?.goToCandidateView(candidateId: candidateID)
    }
    
    func openResourceURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return print("Failed to create URL from urlString.")
        }
        coordinator?.openResourceURL(url)
    }
    
    func onTapLeader(id: String) {
        coordinator?.goToCandidateView(candidateId: id)
    }
}
