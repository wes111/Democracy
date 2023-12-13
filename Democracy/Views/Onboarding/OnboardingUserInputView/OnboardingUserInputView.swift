//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

@MainActor protocol OnboardingInputView: View {
    associatedtype ViewModel: InputViewModel
    associatedtype ContentView: View
    var viewModel: ViewModel { get }
    var field: ContentView { get }
    var isShowingProgress: Binding<Bool> { get }
    var onboardingAlert: Binding<OnboardingAlert?> { get }
}

extension OnboardingInputView {
    
    var progressView: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.secondaryText)
    }
    
    var main: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                VStack(alignment: .center, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        title
                        subtitle
                        
                        VStack(alignment: .leading, spacing: 10) {
                            field
                            requirements
                        }
                        
                        VStack {
                            nextButton
                        }
                    }
                    if viewModel.isShowingProgress {
                        progressView
                    }
                }
                .padding()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .toolbarNavigation(topButtons: viewModel.topButtons)
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
                message: Text(alert.message),
                dismissButton: .default(Text("Okay"))
            )
        }
    }
}

// MARK: Private Subviews
private extension OnboardingInputView {
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var subtitle: some View {
        Text(viewModel.subtitle)
            .font(.system(.body, weight: .light))
            .foregroundColor(.primaryText)
            .lineLimit(2...)
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
        VStack(alignment: .leading, spacing: 5) {
            ForEach(viewModel.allErrors, id: \.self) { error in
                if viewModel.text.isEmpty {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .tertiaryText,
                        systemImage: "checkmark.circle"
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
                .font(.system(.caption, weight: .light))
        } icon: {
            Image(systemName: systemImage)
                .frame(width: 20, height: 20) // TODO: This does not control size lol
                .foregroundColor(color)
        }
    }
}
