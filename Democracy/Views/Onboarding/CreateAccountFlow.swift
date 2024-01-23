//
//  CreateAccountFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/23/24.
//

import Foundation

enum CreateAccountFlow: Int, UserInputFlow {
    case username = 0
    case password = 1
    case email = 2
    case phone = 3
}
