//
//  AboutSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/5/23.
//

import Foundation

struct AboutSectionViewModel {
    let summary: String
    
    let memberCountString: String
    let foundedDateString: String
    
    init(
        summary: String,
        memberCount: Int,
        foundedDate: Date
    ) {
        self.summary = summary
        memberCountString = "\(memberCount) Members"
        foundedDateString = "Founded \(foundedDate)"
    }
}
