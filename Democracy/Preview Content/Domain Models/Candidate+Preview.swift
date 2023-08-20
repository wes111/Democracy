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
        externalLink: "www.externalLink.com",
        repType: .legislator,
        badges: [.candidate, .currentRep, .popular]
    )
    
    static let representativePreview = Candidate.preview
    
    static var previewArray: [Candidate] {
        var array: [Candidate] = []
        for _ in 0...20 {
            array.append(
                Candidate(
                    id: UUID(),
                    userName: Candidate.preview.userName,
                    firstName: Candidate.preview.firstName,
                    lastName: Candidate.preview.lastName,
                    imageName: Candidate.preview.imageName,
                    upVotes: Candidate.preview.upVotes,
                    downVotes: Candidate.preview.downVotes,
                    communityId: Candidate.preview.communityId,
                    isRepresentative: Candidate.preview.isRepresentative,
                    summary: Candidate.preview.summary,
                    externalLink: Candidate.preview.externalLink,
                    repType: Candidate.preview.repType,
                    badges: [.candidate, .currentRep, .popular]
                )
            )
        }
        
        for _ in 0...20 {
            array.append(
                Candidate(
                    id: UUID(),
                    userName: Candidate.preview.userName,
                    firstName: Candidate.preview.firstName,
                    lastName: Candidate.preview.lastName,
                    imageName: Candidate.preview.imageName,
                    upVotes: Candidate.preview.upVotes,
                    downVotes: Candidate.preview.downVotes,
                    communityId: Candidate.preview.communityId,
                    isRepresentative: Candidate.preview.isRepresentative,
                    summary: Candidate.preview.summary,
                    externalLink: Candidate.preview.externalLink,
                    repType: .mod,
                    badges: [.candidate, .currentRep, .popular]
                )
            )
        }
        
        for _ in 0...20 {
            array.append(
                Candidate(
                    id: UUID(),
                    userName: Candidate.preview.userName,
                    firstName: Candidate.preview.firstName,
                    lastName: Candidate.preview.lastName,
                    imageName: Candidate.preview.imageName,
                    upVotes: Candidate.preview.upVotes,
                    downVotes: Candidate.preview.downVotes,
                    communityId: Candidate.preview.communityId,
                    isRepresentative: Candidate.preview.isRepresentative,
                    summary: Candidate.preview.summary,
                    externalLink: Candidate.preview.externalLink,
                    repType: .creator,
                    badges: [.candidate, .currentRep, .popular]
                )
            )
        }
        return array
    }
    
    static var representativePreviewArray: [Candidate] {
        var array: [Candidate] = []
        for _ in 0...10 {
            array.append(
                Candidate(
                    id: UUID(),
                    userName: Candidate.preview.userName,
                    firstName: Candidate.preview.firstName,
                    lastName: Candidate.preview.lastName,
                    imageName: Candidate.preview.imageName,
                    upVotes: Candidate.preview.upVotes,
                    downVotes: Candidate.preview.downVotes,
                    communityId: Candidate.preview.communityId,
                    isRepresentative: Candidate.preview.isRepresentative,
                    summary: Candidate.preview.summary,
                    externalLink: Candidate.preview.externalLink,
                    repType: Candidate.preview.repType,
                    badges: [.candidate, .currentRep, .popular]
                )
            )
        }
        return array
    }
}
