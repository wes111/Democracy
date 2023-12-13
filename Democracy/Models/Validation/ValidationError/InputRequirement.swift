//
//  ValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

// A collection of requirements correspoding to a type of user input.
// Each requirement in the collection has a description and a regex.
protocol InputRequirement: Error, CaseIterable, Hashable {
    var descriptionText: String { get }
    var regex: String { get }
}
