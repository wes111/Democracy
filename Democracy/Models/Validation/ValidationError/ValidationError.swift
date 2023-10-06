//
//  ValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

// A collection of validation errors correspoding to a type of user input.
// Each error in the collection has a description and a regex.
protocol ValidationError: Error, CaseIterable, Hashable {
    var descriptionText: String { get }
    var regex: String { get }
}
