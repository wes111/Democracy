//
//  TextInputScreenModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI

// A modifier intended to be used by 'UserTextInputView','UserMultiInputView', 'UserSelectionView'.
// Standard appearance for any user input screen (text fields, user selection, etc.)
struct UserInputScreen<ViewModel: UserInputViewModel, Content: View>: View {
    @ObservedObject var viewModel: ViewModel
    @ViewBuilder let content: Content
    let additionalSubmitAction: () async -> Void
    
    init(
        viewModel: ViewModel,
        additionalSubmitAction: @escaping () async -> Void = {},
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.additionalSubmitAction = additionalSubmitAction
        self.content = content()
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

// MARK: - Private Subviews
private extension UserInputScreen {
    
    var primaryContent: some View {
        ZStack(alignment: .center) {
            Color.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    UserInputTitle(title: viewModel.title)
                    
                    content
                        .titledElement(title: viewModel.subtitle)
                    
                    skipAndNextButtons
                }
                .padding(ViewConstants.screenPadding)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            if viewModel.isShowingProgress {
                CustomProgressView()
            }
        }
    }
    
    var skipAndNextButtons: some View {
        ZStack {
            if let action = viewModel.skipAction, !viewModel.canSubmit {
                skipButton(action: action)
            } else {
                nextButton
            }
        }
        .animation(.easeInOut, value: viewModel.canSubmit)
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
    
    var nextButton: some View {
        NextButton(
            isShowingProgress: $viewModel.isShowingProgress, 
            nextAction: {
                await additionalSubmitAction()
                await viewModel.submit()
            },
            isDisabled: !viewModel.canSubmit
        )
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTagsViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    
    return NavigationStack {
        UserInputScreen(
            viewModel: viewModel) {
                EmptyView()
            }
    }
}
