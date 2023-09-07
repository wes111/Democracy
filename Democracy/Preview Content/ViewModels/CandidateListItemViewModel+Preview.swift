//
//  CandidateListItemViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/30/23.
//

import Foundation

extension CandidateListItemViewModel {
    
    static let preview = CandidateListItemViewModel(
        score: 99,
        upVotes: 500,
        downVotes: 25,
        memberSince: Date(),
        candidateName: "Bernie Sanders",
        imageName: "bernie"
    )
    
    static var previewArray: [CandidateListItemViewModel] {
        var array: [CandidateListItemViewModel] = []
        for _ in 0...200 {
            array.append(
                .init(
                    score: 99,
                    upVotes: 500,
                    downVotes: 25,
                    memberSince: Date(),
                    candidateName: "Bernie Sanders",
                    imageName: "bernie")
            )
        }
        return array
    }
}
