//
//  CreateCommunityFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum CreateCommunityFlow: Int, UserInputFlow {
    case name = 0
    case description = 1
    case categories = 2
    case tags = 3
    case rules = 4
    case settings = 5
    case leaders = 6
}
