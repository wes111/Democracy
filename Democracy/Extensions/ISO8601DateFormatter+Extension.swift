//
//  ISO8601DateFormatter+Extension.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

import Foundation

extension ISO8601DateFormatter {
    static let sharedWithFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds]
        return formatter
    }()
}
