//
//  CreateAccountSuccessView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import SwiftUI

struct CreateAccountSuccessView: View {
    @ObservedObject var viewModel: CreateAccountSuccessViewModel
    
    init(viewModel: CreateAccountSuccessViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 25) {
                logo
                Spacer()
                welcomeText
                Spacer()
                continueButton
                skipButton
            }
            .padding()
        }
        .toolbarNavigation(topButtons: viewModel.topButtons)
    }
}

// MARK: - Subviews
extension CreateAccountSuccessView {
    var logo: some View {
        Image("BMW")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 100)
    }
    
    var welcomeText: some View {
        VStack(alignment: .center, spacing: 15) {
            VStack(alignment: .center, spacing: 0) {
                Text("Welcome to Democracy,")
                Text(viewModel.username)
            }
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
            
            Text("Your account was created successfully!")
                .font(.system(.body, weight: .regular))
                .foregroundColor(.tertiaryText)
        }
        
    }
    
    var continueButton: some View {
        Button {
            viewModel.continueAction()
        } label: {
            Label {
                Text("Continue Account Setup")
            } icon: {
                Image(systemName: "arrow.right")
            }
            .labelStyle(ReversedLabelStyle())
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    var skipButton: some View {
        Button {
            viewModel.close()
        } label: {
            Text("Skip")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = CreateAccountSuccessViewModel(coordinator: coordinator, username: "Hamlin11")
    return CreateAccountSuccessView(viewModel: viewModel)
}
