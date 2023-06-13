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
    var isShowingNavigationBar: Bool { get }
    var selectedCommunityArchiveType: String { get }
    
    func showCreatePostView()
    func getCommunityHomeFeedViewModel() -> CommunityHomeFeedViewModel
    func getCommunityInfoViewModel() -> CommunityInfoViewModel
    func getCommunityArchiveFeedViewModel() -> CommunityArchiveFeedViewModel
    func goBack()
    func updateCommunityArchiveType(_ type: CommunityArchiveType)
}

final class CommunityViewModel: CommunityViewModelProtocol {
    
    @Published var isShowingNavigationBar = true
    @Published var selectedCommunityArchiveType = CommunityArchiveType.category.title
    @Injected(\.communityService) private var communityService
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
        
        subscribeToCommunityArchiveType()
    }
    
    private func subscribeToCommunityArchiveType() {
        communityService.communityArchiveType
            .sink { [weak self] type in
                self?.newCommunityArchiveType(type)
            }
            .store(in: &cancellables)
    }
    
    private func newCommunityArchiveType(_ type: CommunityArchiveType) {
        Task {
            await MainActor.run {
                selectedCommunityArchiveType = type.title
            }
        }
    }
    
    func updateCommunityArchiveType(_ type: CommunityArchiveType) {
        communityService.updateCommunityArchiveType(type)
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
