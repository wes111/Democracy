//
//  EmptyRequirement.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/14/24.
//

import Foundation

enum NoneRequirement: InputRequirement {
    var descriptionText: String {
        ""
    }
    
    // Matches any String.
    var regex: String {
        ".*"
    }
}
