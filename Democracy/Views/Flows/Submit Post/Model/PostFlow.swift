//
//  PostFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation

enum PostFlow: UserInputFlow {
    case title(PostTitleViewModel)
    case primaryLink(PostPrimaryLinkViewModel)
    case body(PostBodyViewModel)
    case category(PostCategoryViewModel)
    case tags(PostTagsViewModel)
    
    enum ID: CaseIterable, Hashable {
        case title, primaryLink, body, category, tags
    }
    
    var progress: Int {
        switch self {
        case .title: 0
        case .primaryLink: 1
        case .body: 2
        case .category: 3
        case .tags: 4
        }
    }
    
    var title: String {
        switch self {
        case .title: "Add a Title"
        case .primaryLink: "Add a Primary Link"
        case .body: "Add Content"
        case .category: "Select a Category"
        case .tags: "Add Tags"
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
}
