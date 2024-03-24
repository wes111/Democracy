//
//  UserInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

// A viewModel for Views that are part of a user input flow.
// User input can be text, selection, etc.
@MainActor
protocol InputFlowViewModel: Observable, AnyObject {
    associatedtype Flow: UserInputFlow
    
    var flowPath: Flow? { get }
    var leadingButtons: [ToolBarLeadingContent] { get }
    var trailingButtons: [OnboardingTopButton] { get }
    var totalProgress: Int { get }
    var currentProgress: Int { get }
    var viewTitle: String { get }
    var viewSubtitle: String { get }
}

extension InputFlowViewModel {
    var currentProgress: Int {
        flowPath?.progress ?? 0
    }
    
    var viewTitle: String {
        flowPath?.title ?? ""
    }
    
    var viewSubtitle: String {
        flowPath?.subtitle ?? ""
    }
    
    var totalProgress: Int {
        Flow.ID.allCases.count
    }
}
