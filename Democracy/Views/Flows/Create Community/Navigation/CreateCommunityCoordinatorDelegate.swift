//
//  CreateCommunityCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor
protocol CreateCommunityCoordinatorDelegate: FlowCoordinatorDelegate {
    func didSubmitName(input: CreateCommunityInput)
    func didSubmitDescription(input: CreateCommunityInput)
    func didSubmitCategories(input: CreateCommunityInput)
    func didSubmitTags(input: CreateCommunityInput)
    func didSubmitRules(input: CreateCommunityInput)
    func didSubmitSettings(input: CreateCommunityInput)
    func didSubmitLeaders(input: CreateCommunityInput)
}
