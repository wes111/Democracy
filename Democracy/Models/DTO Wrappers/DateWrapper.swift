//
//  DateWrapper.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/5/24.
//

import Foundation

// TODO: - Make this into a decoding strategy instead of the wrapper here...
struct DateWrapper: Decodable {
    let date: Date

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        guard let date = ISO8601DateFormatter.sharedWithFractionalSeconds.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date format"
            )
        }
        self.date = date
    }
}
