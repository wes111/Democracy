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

extension SubmitPostFlow {
    
    var title: String {
        switch self {
        case .title:
            "Add a Title"
        case .primaryLink:
            "Add a Primary Link"
        case .body:
            "Add Content"
        case .category:
            "Select a Category"
        case .tags:
            "Add Tags"
        }
    }
    
    var subtitle: String {
        switch self {
        case .title:
            "Create a title for your post."
        case .primaryLink:
            """
            Add a primary link to your post with previewable content. If we are unable to fetch the metadata
            for the provided link, please try a different link or skip this step.
            """
        case .body:
            """
            Add text content to your post. Optionally, use markdown to add links, \
            bold, italics, and more to your post
            """
        case .category:
            "Each post belongs to a single category within a Community."
        case .tags:
            "Add community tags to your post to improve searchability."
            
        }
    }
    
    var required: Bool {
        switch self {
        case .title, .body, .category, .tags:
            true
        case .primaryLink:
            false
        }
    }
}
