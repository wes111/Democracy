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
}

protocol CommunityInfoViewModelProtocol: ObservableObject {
    
    var representatives: [Candidate] { get }
    var alliedCommunities: [Community] { get }
    var coordinator: CommunityInfoCoordinatorDelegate { get }
    var community: Community { get }

    func showCandidates()
    func updateIsShowingPicker(_ newState: Bool)
    func onTapCommunityCard(_ community: Community)
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
    
    func updateIsShowingPicker(_ newState: Bool) {
        //communityViewController.updateIsShowingPickerView(newState)
    }
    
    func onTapCommunityCard(_ community: Community) {
        coordinator.goToCommunity(community)
    }
    
}
