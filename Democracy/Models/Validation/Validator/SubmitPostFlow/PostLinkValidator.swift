//
//  PostLinkValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

struct PostLinkValidator: InputValidator {
    typealias Requirement = EmptyRequirement
    static var field: SubmitPostField = .link
}
