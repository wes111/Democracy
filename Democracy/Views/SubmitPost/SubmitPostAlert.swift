//
//  SubmitPostAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

enum SubmitPostAlert: AlertModelProtocol {
    case generic
    
    var title: String {
        "Invalid Length"
    }
    
    var description: String {
        "Enter a valid input" // TODO: ...
    }
}
