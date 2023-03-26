//
//  Community+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Community {
    static let preview = Community(name: "Test Community", foundedDate: Date(), representatives: Candidate.representativePreviewArray)
    
    static var previewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(Community(name: "Test Community \(index)", foundedDate: Date(), representatives: Candidate.representativePreviewArray))
        }
        return array
    }
}
