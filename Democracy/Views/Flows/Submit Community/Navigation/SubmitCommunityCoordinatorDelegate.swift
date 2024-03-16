//
//  CreateCommunityCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor
protocol SubmitCommunityCoordinatorDelegate: FlowCoordinatorDelegate {
    func goToSuccess(communityName: String)
}
