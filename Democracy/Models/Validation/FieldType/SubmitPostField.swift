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
            1000
        case .link:
            500
        case .tags:
            100 // TODO: ...
        }
    }
    
    var fullRegex: String {
        switch self {
            
        /// Checks if the string is between 1 and 100 characters in length.
        case .title:
            "^.{1,100}$"
            
        /// Checks if the string is between 1 and 1000 characters in length.
        case .body:
            "^.{1,1000}$"
            
        /// Checks if the string is between 1 and 100 characters in length.
        case .link:
            "^.{1,100}$"
            
        case .tags:
            "" // TODO: ...
        }
    }
    
    var alertTitle: String {
        "Invalid Length"
    }
    
    var alertDescription: String {
        "Enter a valid input" // TODO: ...
    }
}
