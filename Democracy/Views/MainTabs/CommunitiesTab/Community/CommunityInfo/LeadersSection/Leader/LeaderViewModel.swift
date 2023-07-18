//
//  LeaderViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation

struct LeaderViewModel: Hashable, Identifiable {
    
    let id: UUID
    
    private let candidate: Candidate
    
    var imageName: String {
        candidate.imageName ?? ""
    }
    
    var candidateName: String {
        candidate.userName
    }
    
    init(
         candidate: Candidate
    ) {
        self.candidate = candidate
        self.id = candidate.id
    }
    
}
