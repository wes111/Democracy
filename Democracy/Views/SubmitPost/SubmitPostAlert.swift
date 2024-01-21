//
//  SubmitPostAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

enum SubmitPostAlert: AlertModelProtocol {
    case invalidTitle, invalidLink, invalidBody, failedFetchingLinkMetadata, createPostFailed
    
    var title: String {
        switch self {
        case .invalidTitle:
            "Invalid Title"
        case .invalidLink:
            "Invalid Link"
        case .invalidBody:
            "Invalid Body"
        case .failedFetchingLinkMetadata:
            "Unable to Verify Link"
        case .createPostFailed:
            "Create Post Failed"
        }
    }
    
    var description: String {
        switch self {
        case .invalidTitle:
            "Enter a title that meets the requirements."
        case .invalidLink:
            "Enter a link that meets the requirements or skip adding a link."
        case .invalidBody:
            "Enter a body that meets the requirements."
        case .failedFetchingLinkMetadata:
            "Ensure the link you provided is valid or try again later."
        case .createPostFailed:
            "Please try again later."
        }
    }
}
