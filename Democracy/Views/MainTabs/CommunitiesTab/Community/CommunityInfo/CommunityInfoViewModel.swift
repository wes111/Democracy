//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

protocol CommunityInfoCoordinatorDelegate: 
    CandidateCardCoordinatorDelegate, LeadersCoordinatorDelegate, AlliedDelegate, AnyObject {
    @MainActor func showCandidates()
    @MainActor func goToCommunityView(id: String)
    @MainActor func openResourceURL(_ url: URL)
}

final class CommunityInfoViewModel: ObservableObject {

    @Published var representatives: [Candidate] = Candidate.previewArray
    @Published var alliedCommunities: [Community] = Community.myCommunitiesPreviewArray
    
    private weak var coordinator: CommunityInfoCoordinatorDelegate?
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
    
    init(coordinator: CommunityInfoCoordinatorDelegate?,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
        
        resourcesSectionViewModel = .init(
            title: "Resources",
            resources: community.resources
        )
        
        aboutSectionViewModel = .init(
            summary: community.description,
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
        coordinator?.goToCommunityView(id: community.id)
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
