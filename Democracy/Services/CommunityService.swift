//
//  CommunityService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/11/23.
//

import Combine
import Foundation

enum CommunityArchiveType {
    case time, category
    
    var title: String {
        switch self {
        case .time: return "Time"
        case .category: return "Category"
        }
    }
}

/// The purpose of this class is to hold shared state within the Community Views, particularly user selections.
protocol CommunityServiceProtocol {
    
    var communityArchiveType: AnyPublisher<CommunityArchiveType, Never> { get }
    
    func updateCommunityArchiveType(_ type: CommunityArchiveType)
}

final class CommunityService: CommunityServiceProtocol {
    
    private var communityArchiveTypeSubject = CurrentValueSubject<CommunityArchiveType, Never>(.category)
    
    var communityArchiveType: AnyPublisher<CommunityArchiveType, Never> {
        communityArchiveTypeSubject.eraseToAnyPublisher()
    }
    
    func updateCommunityArchiveType(_ type: CommunityArchiveType) {
        communityArchiveTypeSubject.send(type)
    }
    
}
