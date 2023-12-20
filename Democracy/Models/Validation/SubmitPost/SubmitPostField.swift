//
//  SubmitPostField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

enum SubmitPostField: InputField {
    case title, body, link, tags
    
    var title: String {
        switch self {
        case .title:
            "Add a Title"
        case .body:
            "Add Content"
        case .link:
            "Add a Link"
        case .tags:
            "Add Tags"
        }
    }
    
    var subtitle: String {
        switch self {
        case .title:
            "Create a title for your post."
        case .body:
            "Add text content to your post."
        case .link:
            "Add a primary link to your post."
        case .tags:
            "Add community tags to your post to improve searchability."
        }
    }
    
    var fieldTitle: String {
        switch self {
        case .title:
            "Post Title"
        case .body:
            "Post Body"
        case .link:
            "Post Link"
        case .tags:
            "Post Tags"
        }
    }
    
    var required: Bool {
        switch self {
        case .title, .body, .tags:
            true
        case .link:
            false
        }
    }
    
    var maxCharacterCount: Int {
        switch self {
        case .title:
            100
        case .body:
            1000 // TODO: ...
        case .link:
            500 // TODO: ...
        case .tags:
            100 // TODO: ...
        }
    }
    
    var fullRegex: String {
        ""
    }
    
    var alertTitle: String {
        ""
    }
    
    var alertDescription: String {
        ""
    }
}
