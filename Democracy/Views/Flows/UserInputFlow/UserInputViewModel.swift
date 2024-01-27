//
//  UserInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

protocol UserInputFlow: CaseIterable, RawRepresentable where RawValue == Int {
    var title: String { get }
    var subtitle: String { get }
    var required: Bool { get }
}

protocol UserInputViewModel: Hashable, Observable, AnyObject {
    associatedtype Flow: UserInputFlow
    var flowCase: Flow { get }
    var isShowingProgress: Bool { get set }
    var trailingButtons: [OnboardingTopButton] { get }
    var leadingButtons: [OnboardingTopButton] { get }
    var alertModel: NewAlertModel? { get set }
    @MainActor var skipAction: (() -> Void)? { get }
    
    // In most cases, 'submit' and 'nextButtonAction' will be the same.
    // Override the 'submit' function if it should have different behavior.
    // See 'CommunityTagsView' as an example for when behavior should differ.
    var canSubmit: Bool { get }
    func submit() async
    
    var canPerformNextAction: Bool { get }
    func nextButtonAction() async
}

extension UserInputViewModel {
    func submit() async {
        await nextButtonAction()
    }
    
    var canSubmit: Bool {
        canPerformNextAction
    }
    
    var title: String {
        flowCase.title
    }
    
    var subtitle: String {
        flowCase.subtitle
    }
}
