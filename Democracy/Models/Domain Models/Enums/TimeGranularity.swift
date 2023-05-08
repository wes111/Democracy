//
//  TimeGranularity.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/3/23.
//

import Foundation

enum TimeGranularity: String, CaseIterable, CustomStringConvertible {
    
    case day, month, year // A user selects one to determine granularity of posts.
    
    var description: String {
        self.rawValue
    }
}
