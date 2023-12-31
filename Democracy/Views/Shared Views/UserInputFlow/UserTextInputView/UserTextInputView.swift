//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

struct UserTextInputView<ViewModel: UserTextInputViewModel, Content: View>: View {
    @ObservedObject var viewModel: ViewModel
    @ViewBuilder let content: Content
    
    init(
        viewModel: ViewModel,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content()
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

private extension UserTextInputView {
    
    var primaryContent: some View {
        ZStack(alignment: .center) {
            Color.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                    VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                            title
                            
                            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                                content
                                    .titledElement(title: viewModel.subtitle)
                                
                                requirements
                            }
                            nextButton
                        }
                        
                        if !viewModel.field.required {
                            skipButton
                        }
                    }
                    .padding(ViewConstants.screenPadding)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            if viewModel.isShowingProgress {
                CustomProgressView()
            }
        }
    }
    
    var skipButton: some View {
        Button {
            viewModel.skip()
        } label: {
            Label("Skip", systemImage: SystemImage.arrowRight.rawValue)
                .labelStyle(ReversedLabelStyle())
        }
        .disabled(viewModel.isShowingProgress)
        .buttonStyle(SeconaryButtonStyle())
    }
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var nextButton: some View {
        AsyncButton(
            action: { await viewModel.submit() },
            label: { Text("Next") },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canSubmit)
    }
    
    var requirements: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
            ForEach(viewModel.allErrors, id: \.self) { error in
                if viewModel.text.isEmpty {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .primaryText,
                        systemImage: SystemImage.asterisk.rawValue
                    )
                } else if viewModel.textErrors.contains(error) {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .yellow,
                        systemImage: SystemImage.exclamationmarkTriangle.rawValue
                    )
                } else {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .green,
                        systemImage: SystemImage.checkmarkCircleFill.rawValue
                    )
                }
            }
            .foregroundColor(.tertiaryText)
        }
    }
    
    func requirementLabel(text: String, color: Color, systemImage: String) -> some View {
        Label {
            Text(text)
        } icon: {
            Image(systemName: systemImage)
                .foregroundColor(color)
                .frame(width: 10, height: 10)
        }
        .font(.system(.caption, weight: .light))
    }
}
