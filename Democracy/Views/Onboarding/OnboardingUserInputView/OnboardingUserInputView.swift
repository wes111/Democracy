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
    var errors: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(viewModel.textErrors, id: \.self) { error in
                Label {
                    Text(error.descriptionText)
                        .font(.system(.caption, weight: .light))
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                }
                .foregroundColor(.otherRed)
            }
        }
    }
    
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
    
    var main: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                title
                subtitle
                field
                errors
                
                VStack {
                    nextButton
                    Spacer()
                }
                .ignoresSafeArea(.keyboard)
            }
            .padding()
            
            if viewModel.isShowingProgress {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
            }
        }
        .toolbarNavigation(topButtons: viewModel.topButtons)
        .onSubmit {
            performAsnycTask(
                action: viewModel.submit,
                isShowingProgress: isShowingProgress
            )
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
