//
//  NextButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI

@MainActor
protocol SubmittableNextButtonViewModel: Observable, AnyObject {
    var isShowingProgress: Bool { get set }
    var canPerformNextAction: Bool { get }
    
    func nextButtonAction() async
}

// A NextButton to be used as part of a user input flow.
@MainActor
struct SubmittableNextButton<ViewModel: SubmittableNextButtonViewModel>: View {
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        NextButton(
            isShowingProgress: $viewModel.isShowingProgress,
            nextAction: {
                await viewModel.nextButtonAction()
            },
            isDisabled: !viewModel.canPerformNextAction
        )
    }
}

@MainActor
struct NextButton: View {
    @Binding var isShowingProgress: Bool
    var nextAction: @MainActor () async -> Void
    var isDisabled: Bool
    
    var body: some View {
        AsyncButton(
            action: { await nextAction() },
            label: { Text("Next") },
            showProgressView: $isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .isDisabledWithAnimation(isDisabled: isDisabled)
    }
}

// MARK: - Preview
#Preview {
    NextButton(
        isShowingProgress: .constant(false),
        nextAction: {},
        isDisabled: false
    )
}
