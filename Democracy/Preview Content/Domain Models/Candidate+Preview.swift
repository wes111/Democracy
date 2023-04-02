//
//  Candidate+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

extension Candidate {
    
    static let preview = Candidate(
        id: UUID(),
        userName: "Hamlin11",
        firstName: "Bernie",
        lastName: "Sanders",
        imageName: "bernie",
        upVotes: 5,
        downVotes: 4,
        communityId: UUID(),
        isRepresentative: true,
        summary: "Enter the candidate's summary here",
        externalLink: "www.externalLink.com"
    )
    
    static let representativePreview = Candidate.preview
    
    static var previewArray: [Candidate] {
        var array: [Candidate] = [Candidate.preview]
        for _ in 0...100 {
            array.append(Candidate.preview)
        }
        return array
    }
    
    static var representativePreviewArray: [Candidate] {
        var array: [Candidate] = []
        for _ in 0...10 {
            array.append(Candidate.preview)
        }
        return array
    }
}
