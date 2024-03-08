//
//  CommunityGovernment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

enum CommunityGovernment: String, Codable, Selectable {
    case autocracy, democracy
    
    static let metaTitle: String = "Government Type"
    
    var title: String {
        switch self {
        case .autocracy:
            "Autocracy"
        case .democracy:
            "Democracy"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .autocracy:
            "Community leaders are self-appointed and cannot be removed by member consensus."
        case .democracy:
            "Leaders and elected and removed by member consensus."
        }
    }
    
    var image: SystemImage {
        switch self {
        case .autocracy:
            .person
        case .democracy:
            .personThree
        }
    }
}
