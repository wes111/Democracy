//
//  EmptyRequirement.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

enum EmptyRequirement: InputRequirement {
    var descriptionText: String {
        ""
    }
    
    // Matches any String.
    var regex: String {
        ".*"
    }
}
