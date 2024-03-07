//
//  URLWrapper.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/5/24.
//

import Foundation

struct URLOptionalWrapper: Decodable {
    let url: URL?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let urlString = try? container.decode(String.self) {
            url = URL(string: urlString)
        } else {
            url = nil
        }
    }
}
