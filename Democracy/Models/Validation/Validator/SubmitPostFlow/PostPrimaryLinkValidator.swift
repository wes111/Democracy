//
//  PostLinkValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

struct PostPrimaryLinkValidator: InputValidator {
    typealias Requirement = PostLinkRequirement
    static var field: SubmitPostField = .primaryLink
}
