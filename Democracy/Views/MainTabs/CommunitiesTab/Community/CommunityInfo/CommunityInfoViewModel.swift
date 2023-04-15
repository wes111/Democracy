//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

protocol CommunityInfoCoordinatorDelegate: CandidateCardCoordinatorDelegate {
    func showCandidates()
    func goToCommunity(_ community: Community)
    func openResourceURL(_ url: URL)
}

protocol CommunityInfoViewModelProtocol: ObservableObject {
    
    var representatives: [Candidate] { get }
    var alliedCommunities: [Community] { get }
    var coordinator: CommunityInfoCoordinatorDelegate { get }
    var community: Community { get }

    func showCandidates()
    func onTapCommunityCard(_ community: Community)
    func openResourceURL(urlString: String)
}

final class CommunityInfoViewModel: CommunityInfoViewModelProtocol {

    @Published var representatives: [Candidate] = Candidate.previewArray
    @Published var alliedCommunities: [Community] = Community.myCommunitiesPreviewArray
    
    let coordinator: CommunityInfoCoordinatorDelegate
    let community: Community
    
    init(coordinator: CommunityInfoCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    func showCandidates() {
        coordinator.showCandidates()
    }
    
    func onTapCommunityCard(_ community: Community) {
        coordinator.goToCommunity(community)
    }
    
    func openResourceURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return print("Failed to create URL from urlString.")
        }
        coordinator.openResourceURL(url)
    }
    
}
