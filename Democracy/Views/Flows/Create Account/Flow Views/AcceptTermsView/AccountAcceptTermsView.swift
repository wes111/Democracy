//
//  AcceptTermsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import SwiftUI

@MainActor
struct AccountAcceptTermsView<ViewModel: AccountAcceptTermsViewModel>: View {
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        primaryContent
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews
extension AccountAcceptTermsView {
    
    var primaryContent: some View {
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
    }
    
    var title: some View {
        Text("Agree to Democracy's terms and conditions")
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var subtitle: some View {
        Text(
            """
            By tapping I agree, you agree to create an
            account and to Democracy's terms and privacy policy.
            """
        )
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
    AccountAcceptTermsView(viewModel: .preview)
}
