//
//  PostTitleValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

struct PostTitleValidator: InputValidator {
    typealias Requirement = EmptyRequirement
    static var field: SubmitPostField = .title
}
