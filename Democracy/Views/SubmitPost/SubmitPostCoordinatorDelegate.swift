//
//  SubmitPostCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Foundation

protocol SubmitPostCoordinatorDelegate: AnyObject {
    func close()
    func goBack()
    
    func didSubmitTitle(input: SubmitPostInput)
    func didSubmitLink(input: SubmitPostInput)
    func didSubmitBody(input: SubmitPostInput)
    func didSubmitSecondaryLinks(input: SubmitPostInput)
    func didSubmitTags(input: SubmitPostInput)
    func didSubmitCategory(input: SubmitPostInput)
    func didFinish()
}
