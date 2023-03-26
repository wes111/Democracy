//
//  Candidate+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

extension Candidate {
    
    static let preview = Candidate(id: UUID(), userName: "Hamlin11", firstName: "Wesley", lastName: "Luntsford", imageName: "bernie", upVotes: 10, downVotes: 5)
    
    static let representativePreview = Candidate(id: UUID(), userName: "Hamlin11", firstName: "Wesley", lastName: "Luntsford", imageName: "bernie", upVotes: 10, downVotes: 5)
    
    static var previewArray: [Candidate] {
        var array: [Candidate] = [Candidate(id: UUID(), userName: "Bob", firstName: "Wesley", lastName: "Luntsford", imageName: "bernie", upVotes: 2, downVotes: 2)]
        for index in 0...100 {
            array.append(Candidate(id: UUID(), userName: "Bernie", firstName: "Wesley", lastName: "Luntsford", imageName: "bernie", upVotes: index, downVotes: index))
        }
        return array
    }
    
    static var representativePreviewArray: [Candidate] {
        var array: [Candidate] = []
        for index in 0...10 {
            array.append(Candidate(id: UUID(), userName: "Bernie", firstName: "Wesley", lastName: "Luntsford", imageName: "bernie", upVotes: index, downVotes: index))
        }
        return array
    }
}
