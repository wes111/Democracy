//
//  SubmitPostAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

enum SubmitPostAlert: AlertModelProtocol {
    case failedFetchingLinkMetadata, createPostFailed
    
    var title: String {
        switch self {
        case .failedFetchingLinkMetadata:
            "Unable to Verify Link"
        case .createPostFailed:
            "Create Post Failed"
        }
    }
    
    var description: String {
        switch self {
        case .failedFetchingLinkMetadata:
            "Ensure the link you provided is valid or try again later."
        case .createPostFailed:
            "Please try again later."
        }
    }
}
