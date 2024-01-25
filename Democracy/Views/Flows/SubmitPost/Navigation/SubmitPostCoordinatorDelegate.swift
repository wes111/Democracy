//
//  SubmitPostCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor
protocol SubmitPostCoordinatorDelegate: FlowCoordinatorDelegate {
    func didSubmitTitle(input: SubmitPostInput)
    func didSubmitLink(input: SubmitPostInput)
    func didSubmitBody(input: SubmitPostInput)
    func didSubmitTags(input: SubmitPostInput)
    func didSubmitCategory(input: SubmitPostInput)
    func didFinish()
}
