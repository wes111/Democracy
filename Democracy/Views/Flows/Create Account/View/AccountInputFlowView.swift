//
//  AccountInputFlowView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import SwiftUI

struct AccountInputFlowView: View {
    @Bindable var viewModel: AccountInputFlowViewModel
    
    init(viewModel: AccountInputFlowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        InputFlowView(viewModel: viewModel) {
            flowScreen
        }
    }
}

// MARK: - Subviews
private extension AccountInputFlowView {
    @ViewBuilder @MainActor
    var flowScreen: some View {
        switch viewModel.flowPath {
        case .username(let viewModel):
            AccountUsernameView(viewModel: viewModel)
            
        case .email(let viewModel):
            AccountEmailView(viewModel: viewModel)
            
        case .password(let viewModel):
            AccountPasswordView(viewModel: viewModel)
            
        case .phone(let viewModel):
            AccountPhoneView(viewModel: viewModel)
            
        case .acceptTerms(let viewModel):
            AccountAcceptTermsView(viewModel: viewModel)
            
        case .none:
            EmptyView() // TODO: ????
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AccountInputFlowView(viewModel: .preview)
    }
}
