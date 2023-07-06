//
//  CommunityInfoViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

struct LeadershipSectionViewModel {
    let creators: [Candidate]
    let mods: [Candidate]
    let legislators: [Candidate]
    let onTapCandidateCard: (Candidate) -> Void
    
    func sectionTitle(repType: RepresentativeType) -> String {
        repType.description.capitalized
    }
}

protocol CommunityInfoCoordinatorDelegate: CandidateCardCoordinatorDelegate {
    func showCandidates()
    func goToCommunity(_ community: Community)
    func goToCandidateView(_ candidate: Candidate)
    func openResourceURL(_ url: URL)
}

final class CommunityInfoViewModel: ObservableObject {

    @Published var representatives: [Candidate] = Candidate.previewArray
    @Published var alliedCommunities: [Community] = Community.myCommunitiesPreviewArray
    
    let coordinator: CommunityInfoCoordinatorDelegate
    let community: Community
    
    let resourcesSectionViewModel: ResourcesSectionViewModel
    let aboutSectionViewModel: AboutSectionViewModel
    
    var leadershipSectionViewModel: LeadershipSectionViewModel {
        .init(
            creators: Candidate.previewArray.filter { $0.repType == .creator },
            mods: Candidate.previewArray.filter { $0.repType == .mod },
            legislators: Candidate.previewArray.filter { $0.repType == .legislator },
            onTapCandidateCard: onTapCandidateCard
        )
    }
    
    init(coordinator: CommunityInfoCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
        
        resourcesSectionViewModel = .init(
            title: "Resources",
            resources: community.resources
        )
        
        aboutSectionViewModel = .init(
            summary: community.summary,
            memberCount: community.memberCount,
            foundedDate: community.foundedDate
        )
    }
    
    func showCandidates() {
        coordinator.showCandidates()
    }
    
    func onTapCommunityCard(_ community: Community) {
        coordinator.goToCommunity(community)
    }
    
    func onTapCandidateCard(_ candidate: Candidate) {
        coordinator.goToCandidateView(candidate)
    }
    
    func openResourceURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return print("Failed to create URL from urlString.")
        }
        coordinator.openResourceURL(url)
    }
    
}
