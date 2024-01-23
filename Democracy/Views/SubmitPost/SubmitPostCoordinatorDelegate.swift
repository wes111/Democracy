//
//  SubmitPostCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

@MainActor
protocol SubmitPostCoordinatorDelegate: AnyObject {
    func didSubmitTitle(input: SubmitPostInput)
    func didSubmitLink(input: SubmitPostInput)
    func didSubmitBody(input: SubmitPostInput)
    func didSubmitTags(input: SubmitPostInput)
    func didSubmitCategory(input: SubmitPostInput)
    func didFinish()
    
    func goBack()
    func close()
}
