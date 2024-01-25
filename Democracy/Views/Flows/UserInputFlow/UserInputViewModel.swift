//
//  UserInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

protocol UserInputFlow: CaseIterable, RawRepresentable where RawValue == Int {}

protocol UserInputViewModel: Hashable, Observable, AnyObject {
    associatedtype Flow: UserInputFlow
    var flowCase: Flow { get }
    var isShowingProgress: Bool { get set }
    var trailingButtons: [OnboardingTopButton] { get }
    var leadingButtons: [OnboardingTopButton] { get }
    var alertModel: NewAlertModel? { get set }
    var title: String { get }
    var subtitle: String { get }
    var canSubmit: Bool { get }
    @MainActor var skipAction: (() -> Void)? { get }
    
    func submit() async
}
