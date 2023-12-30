//
//  UserFlowSelectView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SwiftUI

struct UserSelectionView<ViewModel: UserSelectionViewModel, Content: View>: View {
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
            .onSubmit {
                if viewModel.canSubmit {
                    performAsnycTask(
                        action: viewModel.submit,
                        isShowingProgress: $viewModel.isShowingProgress
                    )
                }
            }
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
        EmptyView()
    }
}
