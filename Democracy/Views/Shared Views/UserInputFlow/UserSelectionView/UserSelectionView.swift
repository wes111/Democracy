//
//  UserFlowSelectView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SwiftUI

struct UserSelectionView<ViewModel: UserInputViewModel, Content: View>: View {
    @ObservedObject var viewModel: ViewModel
    @ViewBuilder let selectableContent: Content
    
    init(viewModel: ViewModel, @ViewBuilder selectableContent: () -> Content) {
        self.viewModel = viewModel
        self.selectableContent = selectableContent()
    }
    
    var body: some View {
        primaryContent
    }
}

private extension UserSelectionView {
    
    var primaryContent: some View {
        UserInputScreen(viewModel: viewModel) {
            VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    UserInputTitle(title: viewModel.title)
                    
                    selectableContent
                        .titledElement(title: viewModel.subtitle)
                }
                nextButton
            }
        }
    }
    
    var nextButton: some View {
        NextButton(
            isShowingProgress: $viewModel.isShowingProgress,
            nextAction: viewModel.submit,
            isDisabled: !viewModel.canSubmit
        )
    }
}
