//
//  PostTagsValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/29/23.
//

import Foundation

struct PostTagsValidator: InputValidator {
    typealias Requirement = EmptyRequirement
    static var field: SubmitPostField = .tags
}
