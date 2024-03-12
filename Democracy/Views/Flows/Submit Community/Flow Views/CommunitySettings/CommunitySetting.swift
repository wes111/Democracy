//
//  CommunitySetting.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

enum CommunitySetting: Identifiable {
    
    case governmentType, allowsAdultContent, visibility, poster, commenter, postApproval
    
    var id: Int {
        switch self {
        case .governmentType: 1
        case .allowsAdultContent: 2
        case .visibility: 3
        case .poster: 4
        case .commenter: 5
        case .postApproval: 6
        }
    }
}
