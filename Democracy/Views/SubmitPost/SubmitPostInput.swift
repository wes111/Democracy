//
//  SubmitPostInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

class SubmitPostInput {
    var title: String?
    var link: String?
    var body: String?
    var tags: [Tag]
    
    init(title: String? = nil, link: String? = nil, body: String? = nil, tags: [Tag] = []) {
        self.title = title
        self.link = link
        self.body = body
        self.tags = tags
    }
}
