//
//  CreateCommunityAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/3/23.
//

import Foundation

enum CreateCommunityAlert: Identifiable {
    case missingTitle
    
    var id: String {
        return self.title
    }
    
    var title: String {
        switch self {
        case .missingTitle: return "Missing Title"
        }
    }
    
    var message: String {
        switch self {
        case .missingTitle: return "Communities require titles."
        }
    }
}
