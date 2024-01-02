//
//  SubmitPostField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

enum SubmitPostField: InputField {
    case title, body, link
    
    var title: String {
        switch self {
        case .title:
            "Add a Title"
        case .body:
            "Add Content"
        case .link:
            "Add a Link"
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
        }
    }
    
    var required: Bool {
        switch self {
        case .title, .body:
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
            
        // The String must begin with "https://"
        // The string must be between 9 and 500 characters long.
        case .link:
            "^https://.{1,500}$"
        }
    }
    
    var alert: SubmitPostAlert {
        switch self {
        case .title:
            .invalidTitle
            
        case .body:
            .invalidBody
            
        case .link:
            .invalidLink
        }
    }
}
