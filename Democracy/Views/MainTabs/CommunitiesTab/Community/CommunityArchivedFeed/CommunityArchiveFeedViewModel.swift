//
//  CommunityArchiveFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Factory
import Foundation

protocol CommunityArchiveFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
    func goToCommunityPostCategory(_ category: String)
}

protocol CommunityArchiveFeedViewModelProtocol: ObservableObject {
    var timeGranularity: TimeGranularity { get set }
//    var selectedMonth: Month { get set }
//    var selectedDate: Date { get set }
//    var selectedYear: Int { get set }
    
    var community: Community { get }
    func goToCommunityPostCategory(_ category: String)
    var categoryViewModels: [CategoryCardViewModel] { get }
}

final class CommunityArchiveFeedViewModel: CommunityArchiveFeedViewModelProtocol {
    
    @Published var timeGranularity: TimeGranularity = .month
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
    }
    
    func goToCommunityPostCategory(_ category: String) {
        coordinator.goToCommunityPostCategory(category)
    }
    
    var categoryViewModels: [CategoryCardViewModel] {
        CategoryCardViewModel.previewArray
    }
    
}
