//
//  Decodable+Extension.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/7/24.
//

import Foundation

extension Decodable {
    
    // Decode a dictionary with values that do not conform to 'Codable' (e.g. 'Any') to
    // a Decodable struct.
    // swiftlint:disable:next line_length
    // https://stackoverflow.com/questions/68209205/how-to-directly-convert-a-dictionary-to-a-codable-instance-in-swift
    init<Key: Hashable>(_ dict: [Key: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dict, options: [])
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
