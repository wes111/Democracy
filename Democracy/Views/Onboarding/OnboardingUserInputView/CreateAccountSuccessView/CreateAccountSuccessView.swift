//
//  CreateAccountSuccessView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import SwiftUI

struct CreateAccountSuccessView: View {
    @ObservedObject private var viewModel: CreateAccountSuccessViewModel
    private let centerText = "Your account was created successfully!"
    
    init(viewModel: CreateAccountSuccessViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SuccessView(
            primaryText: Text("Welcome to Democracy,\n \(viewModel.username)"),
            secondaryText: Text("Your account was created successfully!"),
            image: Image("BMW"),
            primaryButtonInfo: viewModel.primaryButtonInfo,
            secondaryButtonInfo: viewModel.secondaryButtonInfo
        )
        .toolbarNavigation(trailingButtons: viewModel.trailingButtons)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = CreateAccountSuccessViewModel(
        coordinator: OnboardingCoordinator.preview,
        username: "Hamlin11"
    )
    return NavigationStack {
        CreateAccountSuccessView(viewModel: viewModel)
    }
}
