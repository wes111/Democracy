//
//  Community+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Community {
    static let preview = Community(id: UUID(), name: "Test Community", foundedDate: Date(), representatives: Candidate.representativePreviewArray)
    
    static var previewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(Community(id: UUID(), name: "Test Community \(index)", foundedDate: Date(), representatives: Candidate.representativePreviewArray))
        }
        return array
    }
    
    static let communityCardTapAction: (Community) -> Void = { _ in
        print("Community Card tapped.")
    }
}
