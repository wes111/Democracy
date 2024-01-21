//
//  SubmitPostInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

// Models the user's input through the Submit Post flow.
// Initially there is no user input, hence the optional and empty collection types.
class SubmitPostInput {
    var title: String?
    var primaryLink: String?
    var body: String?
    var tags: Set<String>
    var category: String?
    
    init(
        title: String? = nil,
        link: String? = nil,
        body: String? = nil,
        tags: Set<String> = [],
        category: String? = nil
    ) {
        self.title = title
        self.primaryLink = link
        self.body = body
        self.tags = tags
        self.category = category
    }
}
