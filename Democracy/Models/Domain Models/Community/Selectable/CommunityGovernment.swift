//
//  CommunityGovernment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation
import SharedResourcesClientAndServer

extension CommunityGovernment: Selectable {
    static let metaTitle: String = "Government Type"
    static let metaImage: SystemImage = .buildingColumns
    
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
    
    var image: SystemImage? {
        switch self {
        case .autocracy:
            .person
        case .democracy:
            .personThree
        }
    }
}
