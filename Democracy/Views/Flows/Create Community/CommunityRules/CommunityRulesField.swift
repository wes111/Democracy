//
//  CommunityRulesField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/28/24.
//

import Foundation

// The TextFields of the CommunityRulesView.
enum CommunityRulesField: Hashable {
    case title, description
    
    var fieldTitle: String {
        switch self {
        case .title:
            "Title"
        case .description:
            "Description"
        }
    }
}
