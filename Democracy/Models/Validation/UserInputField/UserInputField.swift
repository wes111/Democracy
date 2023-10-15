//
//  UserInputField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

// Corresponds to a type of user input (e.g. email, password, username, etc.) with a TextField.
protocol UserInputField: UserInputValidator {
    var id: String { get }
    var title: String { get }
    var subtitle: String { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
    
    var alertTitle: String { get }
    var alertDescription: String { get }
    
    init()
}

extension UserInputField {
    var id: String {
        title
    }
}
