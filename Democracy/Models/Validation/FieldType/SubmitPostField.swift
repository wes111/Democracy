//
//  SubmitPostField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

enum SubmitPostField: InputField {
    case title, body, primaryLink, secondaryLinks
    
    var title: String {
        switch self {
        case .title:
            "Add a Title"
        case .body:
            "Add Content"
        case .primaryLink:
            "Add a Primary Link"
        case .secondaryLinks:
            "Add Secondary Links"
        }
    }
    
    var subtitle: String {
        switch self {
        case .title:
            "Create a title for your post."
        case .body:
            """
            Add text content to your post. Optionally, use markdown to add links, \
            bold, italics, and more to your post
            """
        case .primaryLink:
            """
            Add a primary link to your post with previewable content. If we are unable to fetch the metadata
            for the provided link, please try a different link or skip this step.
            """
        case .secondaryLinks:
            "Optionally add secondary links to your post. These will appear at the bottom of your post."
        }
    }
    
    var fieldTitle: String {
        switch self {
        case .title:
            "Post Title"
        case .body:
            "Post Body"
        case .primaryLink:
            "Post Link"
        case .secondaryLinks:
            "Secondary Link"
        }
    }
    
    var required: Bool {
        switch self {
        case .title, .body:
            true
        case .primaryLink, .secondaryLinks:
            false
        }
    }
    
    var maxCharacterCount: Int {
        switch self {
        case .title:
            100
        case .body:
            1000
        case .primaryLink, .secondaryLinks:
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
        case .primaryLink, .secondaryLinks:
            "^https://.{1,500}$"
        }
    }
    
    var alert: SubmitPostAlert {
        switch self {
        case .title:
            .invalidTitle
            
        case .body:
            .invalidBody
            
        case .primaryLink, .secondaryLinks:
            .invalidLink
        }
    }
}
