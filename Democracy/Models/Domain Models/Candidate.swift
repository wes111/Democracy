//
//  Candidate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

struct Candidate: Comrade, Hashable, Identifiable {
    var id: UUID
    var userName: String
    var firstName: String?
    var lastName: String?
    let imageName: String?
}
