//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import Factory
import Foundation

protocol CommunityCoordinatorDelegate: CommunityHomeFeedCoordinatorDelegate, CommunityInfoCoordinatorDelegate, CommunityArchiveFeedCoordinatorDelegate {
    func showCreatePostView()
    func goBack()
}

protocol CommunityViewModelProtocol: ObservableObject {
    var community: Community { get }
    var coordinator: CommunityCoordinatorDelegate { get }
    var canCreatePost: Bool { get }
    //var scrollOffset: CGPoint { get }
    var isShowingNavigationBar: Bool { get }
    
    func showCreatePostView()
    func getCommunityHomeFeedViewModel() -> CommunityHomeFeedViewModel
    func getCommunityInfoViewModel() -> CommunityInfoViewModel
    func getCommunityArchiveFeedViewModel() -> CommunityArchiveFeedViewModel
    func goBack()
}

final class CommunityViewModel: CommunityViewModelProtocol {
    
    @Injected(\.scrollLocationService) private var scrollLocationService
    
    @Published var isShowingNavigationBar = true

    private var cancellables = Set<AnyCancellable>()
    let coordinator: CommunityCoordinatorDelegate
    let community: Community
    var canCreatePost: Bool {
        return true
        // Communityinteractor.canMakePostsInThisCommunity
    }
    
    init(coordinator: CommunityCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
        subscribeToScrollOffset()
    }
    
    private func subscribeToScrollOffset() {
        scrollLocationService
            .subscribeToLocations()
            .sink { offset in
                print("New offset: \(offset)")
                if offset.y <= 10 {
                    Task {
                        await MainActor.run  {
                            if !self.isShowingNavigationBar {
                                self.isShowingNavigationBar = true
                            }
                        }
                    }
                } else {
                    Task {
                        await MainActor.run {
                            if self.isShowingNavigationBar {
                                self.isShowingNavigationBar = false
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func showCreatePostView() {
        coordinator.showCreatePostView()
    }
    
    func getCommunityHomeFeedViewModel() -> CommunityHomeFeedViewModel {
        CommunityHomeFeedViewModel(coordinator: coordinator)
    }
    
    func getCommunityInfoViewModel() -> CommunityInfoViewModel {
        CommunityInfoViewModel(coordinator: coordinator, community: community)
    }
    
    func getCommunityArchiveFeedViewModel() -> CommunityArchiveFeedViewModel {
        CommunityArchiveFeedViewModel(coordinator: coordinator, community: community)
    }
    
    func goBack() {
        coordinator.goBack()
    }
    
}
