//
//  DateOptionalWrapper.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/6/24.
//

import Foundation

struct DateOptionalWrapper: Decodable {
    let date: Date?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String?.self)
        
        if let dateString, let date =
            ISO8601DateFormatter.sharedWithFractionalSeconds.date(from: dateString)
        {
            self.date = date
        } else {
            self.date = nil
        }
    }
}
