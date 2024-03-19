//
//  AddResourceAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/21/24.
//

import Foundation

enum AddResourceAlert: AlertModelProtocol {
    case invalid
    
    var title: String {
        switch self {
        case .invalid:
            "Invalid Resource"
        }
    }
    
    var description: String {
        switch self {
        case .invalid:
            "Please check that all fields match the requirements."
        }
    }
}
