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
//    var timeGranularity: TimeGranularity { get set }
//    var selectedMonth: Month { get set }
//    var selectedDate: Date { get set }
//    var selectedYear: Int { get set }
    
    var initialDates: [Date] { get }
    var community: Community { get }
    func topPostsForDate(_ date: Date) -> [PostCardViewModel]
    func goToCommunityPostCategory(_ category: String)
}

final class CommunityArchiveFeedViewModel: CommunityArchiveFeedViewModelProtocol {
    
//    @Published var timeGranularity: TimeGranularity = .month
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
    
    // Returns an array of dates the user initially sees on this tab, currently last 7 days.
    lazy var initialDates: [Date] = {
        var days: [Date] = []
        for dayOfWeekCount in 0...6 {
            let date = Date.previousDay(offset: dayOfWeekCount)
            days.append(date)
        }
        return days
    }()
    
    // TODO: ...
    func topPostsForDate(_ date: Date) -> [PostCardViewModel] {
        // Tapping a post card doesn't do anything currently because we're using this privew here. TODO: ...
        PostCardViewModel.previewArray
    }
    
    func goToCommunityPostCategory(_ category: String) {
        coordinator.goToCommunityPostCategory(category)
    }
    
}
