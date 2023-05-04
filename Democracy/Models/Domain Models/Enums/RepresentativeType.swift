//
//  RepresentativeType.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Foundation

enum RepresentativeType: String, Codable, CaseIterable, CustomStringConvertible {

    case mod, legislator, creator
    
    var description: String {
        self.rawValue
    }
}
