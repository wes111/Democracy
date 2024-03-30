//
//  CommunitiesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Combine
import Foundation
import Factory

@MainActor @Observable
final class CommunitiesTabMainViewModel {
    
    var allCommunities: [Community] = []
    var category: CommunitiesCategory = .isMemberOf
    var isShowingProgress: Bool = true
    var fetchCommunitiesTask: Task<Void, Never>?
    
    @ObservationIgnored @Injected(\.communityService) private var communityService
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(coordinator: CommunitiesCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
}

// MARK: - Methods
extension CommunitiesTabMainViewModel {
    func goToCommunity(_ community: Community) {
        coordinator?.goToCommunity(community: community)
    }
    
    func showCreateCommunityView() {
        coordinator?.showCreateCommunityView()
    }
    
    func onAppear() {
        fetchCommunitiesByCategory(category)
    }
    
    func fetchCommunitiesByCategory(_ category: CommunitiesCategory) {
        fetchCommunitiesTask?.cancel()
        allCommunities = []
        
        fetchCommunitiesTask = Task {
            isShowingProgress = true
            do {
                try await Task.sleep(seconds: 1.0)
                switch category {
                case .isMemberOf:
                    allCommunities = try await membershipService.userMemberships().map { $0.community }
                    
                case .isLeaderOf:
                    break // TODO: ...
                case .topCommunities:
                    break // TODO: ...
                case .random:
                    break // TODO: ...
                case .recommendations:
                    allCommunities = try await communityService.fetchAllCommunities()
                }
            } catch {
                // Note: Cannot present an alert here, because cancelling a task (by selecting a different
                // category) will throw an error.
                print(error.localizedDescription)
            }
            isShowingProgress = false
        }
    }
}
