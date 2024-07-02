//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

final class CommunityInfoViewModel: ObservableObject {

    @Published var representatives: [Candidate] = Candidate.previewArray
    @Published var alliedCommunities: [Community] = Community.myCommunitiesPreviewArray
    
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    let community: Community
    
    let resourcesSectionViewModel: ResourcesSectionViewModel
    let aboutSectionViewModel: AboutSectionViewModel
    let rulesSectionViewModel: RulesSectionViewModel
    let alliedCommunitiesSectionViewModel: AlliedCommunitiesSectionViewModel
    
    var leadershipSectionViewModel: LeadersSectionViewModel {
        .init(
            creators: Candidate.previewArray.filter { $0.repType == .creator },
            mods: Candidate.previewArray.filter { $0.repType == .mod },
            legislators: Candidate.previewArray.filter { $0.repType == .legislator },
            coordinator: coordinator
        )
    }
    
    init(coordinator: CommunitiesCoordinatorDelegate?, community: Community) {
        self.coordinator = coordinator
        self.community = community
        
        resourcesSectionViewModel = .init(
            title: "Resources",
            resources: community.resources
        )
        
        aboutSectionViewModel = .init(
            summary: community.descriptionText,
            memberCount: community.memberCount,
            foundedDate: community.creationDate
        )
        
        rulesSectionViewModel = .init(
            rules: [],
            title: "Rules"
        )
        
        alliedCommunitiesSectionViewModel = .init(
            alliedCommunities: Community.myCommunitiesPreviewArray,
            coordinator: coordinator
        )
    }
    
    @MainActor
    func showCandidates() {
        coordinator?.showCandidates()
    }
    
    @MainActor
    func onTapCommunityCard(_ community: Community) {
        coordinator?.goToCommunity(community: community)
    }
    
    @MainActor
    func onTapCandidateCard(candidateID: String) {
        coordinator?.goToCandidateView(candidateId: candidateID)
    }
    
    @MainActor
    func openResourceURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return print("Failed to create URL from urlString.")
        }
        coordinator?.openResourceURL(url)
    }
    
}
