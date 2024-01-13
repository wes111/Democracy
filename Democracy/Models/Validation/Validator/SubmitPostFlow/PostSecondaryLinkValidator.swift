//
//  PostSecondaryLinkValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/12/24.
//

import Foundation

struct PostSecondaryLinkValidator: InputValidator {
    typealias Requirement = PostLinkRequirement
    static var field: SubmitPostField = .secondaryLinks
}
