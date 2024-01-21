//
//  PostLinkRequirement.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import Foundation

enum PostLinkRequirement: InputRequirement {
    case https
    case length
    
    var descriptionText: String {
        switch self {
        case .https:
            "begins with \"https://\""
            
        case .length:
            "valid length"
        }
    }
    
    var regex: String {
        switch self {
        // The String must begin with "https://"
        case .https:
            "^https://"
            
        /// The string must be between 9 and 500 characters long.
        case .length:
            "^.{9,500}$"
        }
    }
}
