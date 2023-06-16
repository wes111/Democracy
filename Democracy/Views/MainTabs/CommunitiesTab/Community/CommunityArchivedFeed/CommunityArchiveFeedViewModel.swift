//
//  CommunityArchiveFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Factory
import Foundation

protocol CommunityArchiveFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
    func goToCommunityPostCategory(_ category: CommunityCategory)
}

final class CommunityArchiveFeedViewModel: ObservableObject {
    
    @Published var timeGranularity: TimeGranularity = .month
    @Published var communityArchiveType: CommunityArchiveType = .category
    @Injected(\.communityService) private var communityService
//    @Published var selectedMonth = Date().month
//    @Published var selectedDate = Date()
//    @Published var selectedYear = Date().yearInt
    
    let coordinator: CommunityArchiveFeedCoordinatorDelegate
    let community: Community
    
    init(coordinator: CommunityArchiveFeedCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
        
        communityService.communityArchiveType.assign(to: &$communityArchiveType)
    }
    
    func goToCommunityPostCategory(_ category: CommunityCategory) {
        coordinator.goToCommunityPostCategory(category)
    }
    
    var categoryViewModels: [CategoryCardViewModel] {
        print(CategoryCardViewModel.preview)
        return CategoryCardViewModel.previewArray
    }
    
}
