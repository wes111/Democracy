//
//  SubmittableNextAndSkipButtons.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import SwiftUI

protocol SubmittableSkipableViewModel: SubmittableNextButtonViewModel {
    @MainActor var skipAction: () -> Void { get }
}

struct SubmittableNextAndSkipButtons<ViewModel: SubmittableSkipableViewModel>: View {
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if !viewModel.canPerformNextAction {
                skipButton(action: viewModel.skipAction)
            } else {
                SubmittableNextButton(viewModel: viewModel)
            }
        }
        // Wait to draw the button until the view has properly placed the button.
        .geometryGroup()
        .animation(.easeInOut, value: viewModel.canPerformNextAction)
    }
    
    func skipButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Label("Skip", systemImage: SystemImage.arrowRight.rawValue)
                .labelStyle(ReversedLabelStyle())
        }
        .disabled(viewModel.isShowingProgress)
        .buttonStyle(SeconaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    SubmittableNextAndSkipButtons(viewModel: PostPrimaryLinkViewModel.preview)
}
