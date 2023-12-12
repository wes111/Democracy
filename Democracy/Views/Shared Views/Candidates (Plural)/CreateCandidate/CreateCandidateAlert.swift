//
//  CreateCandidateAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/27/23.
//

import Foundation

// TODO: ...
enum CreateCandidateAlert: Identifiable {
    case missingTitle
    case missingBody
    case invalidLink
    
    var id: String {
        return self.title
    }
    
    var title: String {
        switch self {
        case .missingTitle: return "Missing Title"
        case .missingBody: return "Missing Body"
        case .invalidLink: return "Invalid Link"
        }
    }
    
    var message: String {
        switch self {
        case .missingTitle: return "Posts require titles."
        case .missingBody: return "Posts require bodies."
        case .invalidLink: return "The provided link is invalid."
        }
    }
}
