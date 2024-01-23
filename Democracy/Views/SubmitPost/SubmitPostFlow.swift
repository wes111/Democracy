//
//  SubmitPostPage.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/22/24.
//

import Foundation

enum SubmitPostFlow: Int, UserInputFlow {
    case title = 0
    case primaryLink = 1
    case body = 2
    case category = 3
    case tags = 4
}
