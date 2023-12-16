//
//  AcceptTermsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import SwiftUI

struct AcceptTermsView: View {
    @ObservedObject var viewModel: AcceptTermsViewModel
    
    init(viewModel: AcceptTermsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                title
                subtitle
                Spacer()
                agreeButton
            }
            .padding()
        }
        .toolbarNavigation(
            leadingButtons: viewModel.leadingButtons,
            trailingButtons: viewModel.trailingButtons
        )
        .alert(item: $viewModel.onboardingAlert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text("Okay"))
            )
        }
    }
}

// MARK: - Subviews
extension AcceptTermsView {
    var title: some View {
        Text("Agree to Democracy's terms and conditions")
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var subtitle: some View {
        Text("By tapping I agree, you agree to create an account and to Democracy's terms and privacy policy.")
            .font(.system(.body, weight: .light))
            .foregroundColor(.primaryText)
    }
    
    var agreeButton: some View {
        AsyncButton(
            action: { await viewModel.agreeToTerms() },
            label: { Text("I agree") }, 
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = AcceptTermsViewModel(coordinator: coordinator, onboardingInput: .init())
    return NavigationStack {
        AcceptTermsView(viewModel: viewModel)
    }
}
