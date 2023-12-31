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
    
    init(
        viewModel: ViewModel,
        @ViewBuilder selectableContent: () -> Content
    ) {
        self.viewModel = viewModel
        self.selectableContent = selectableContent()
    }
    
    var body: some View {
        primaryContent
            .toolbarNavigation(
                leadingButtons: viewModel.leadingButtons,
                trailingButtons: viewModel.trailingButtons
            )
            .alert(item: $viewModel.alertModel) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.description),
                    dismissButton: .default(Text("Okay"))
                )
            }
    }
}

private extension UserSelectionView {
    
    var primaryContent: some View {
        ZStack(alignment: .center) {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    title
                    
                    selectableContent
                        .titledElement(title: viewModel.subtitle)
                }
                nextButton
            }
            .padding(ViewConstants.screenPadding)
            
            if viewModel.isShowingProgress {
                CustomProgressView()
            }
        }
    }
    
    // Note: This matches the title in UserTextInputView.
    var title: some View {
        Text(viewModel.title)
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    // Note: This matches the nextButton in UserTextInputView.
    var nextButton: some View {
        AsyncButton(
            action: { await viewModel.submit() },
            label: { Text("Next") },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canSubmit)
    }
}
