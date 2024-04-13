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
        startMembershipsTask()
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
    
    nonisolated func forceRefreshMemberships() async {
        do {
            try await membershipService.fetchMemberships(refresh: true)
        } catch {
            print(error.localizedDescription)
        }
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
                    try await membershipService.fetchMemberships(refresh: false)
                    
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

// MARK: - Private Methods
private extension CommunitiesTabMainViewModel {
    func startMembershipsTask() {
        Task {
            for await membershipsArray in await membershipService.membershipsStream() {
                allCommunities = membershipsArray.map { $0.community }
            }
        }
    }
}
