//
//  CommunityArchiveFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Factory
import Foundation

protocol CommunityArchiveFeedCoordinatorDelegate {
}

protocol CommunityArchiveFeedViewModelProtocol: ObservableObject {
    var timeGranularity: TimeGranularity { get set }
}

final class CommunityArchiveFeedViewModel: CommunityArchiveFeedViewModelProtocol {
    
    @Published var timeGranularity: TimeGranularity = .month
    
    let coordinator: CommunityArchiveFeedCoordinatorDelegate
    let community: Community
    
    init(coordinator: CommunityArchiveFeedCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
}
