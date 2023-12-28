//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

@MainActor protocol UserInputView: View { // TODO: This should probably just be part of the view instead of a protocol (:
    associatedtype ViewModel: InputViewModel
    associatedtype ContentView: View
    
    var viewModel: ViewModel { get }
    var field: ContentView { get }
    var isShowingProgress: Binding<Bool> { get }
    var onboardingAlert: Binding<NewAlertModel?> { get }
}

extension UserInputView {
    
    var progressView: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.secondaryText)
    }
    
    var main: some View {
        primaryContent
            .toolbarNavigation(
                leadingButtons: viewModel.leadingButtons,
                trailingButtons: viewModel.trailingButtons
            )
            .onSubmit {
                if viewModel.canSubmit {
                    performAsnycTask(
                        action: viewModel.submit,
                        isShowingProgress: isShowingProgress
                    )
                }
            }
            .alert(item: onboardingAlert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.description),
                    dismissButton: .default(Text("Okay"))
                )
            }
    }
}

// MARK: Private Subviews
private extension UserInputView {
    
    var primaryContent: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                    VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                        title
                        
                        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                            field
                                .titledElement(title: viewModel.subtitle)
                            
                            requirements
                        }
                        
                        VStack {
                            nextButton
                        }
                    }
                    if viewModel.isShowingProgress {
                        progressView
                    }
                    
                    if !viewModel.field.required {
                        skipButton
                    }
                }
                .padding()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
    
    var skipButton: some View {
        Button {
            viewModel.skip()
        } label: {
            Label("Skip", systemImage: "arrow.right")
                .labelStyle(ReversedLabelStyle())
        }
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
            showProgressView: isShowingProgress
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
                        systemImage: "asterisk"
                    )
                } else if viewModel.textErrors.contains(error) {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .yellow,
                        systemImage: "exclamationmark.triangle"
                    )
                } else {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .green,
                        systemImage: "checkmark.circle.fill"
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
