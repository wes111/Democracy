//
//  AddRuleAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/27/24.
//

import Foundation

enum AddRuleAlert: AlertModelProtocol {
    case invalid
    
    var title: String {
        switch self {
        case .invalid:
            "Invalid Rule"
        }
    }
    
    var description: String {
        switch self {
        case .invalid:
            "Please check that all fields match the requirements."
        }
    }
}
