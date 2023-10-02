//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

enum CreatePasswordField {
    case password
}

struct CreatePasswordView: View {
    @ObservedObject var viewModel: CreateAccountViewModel
    @FocusState private var focusedField: CreatePasswordField?
    
    init(viewModel: CreateAccountViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                title
                subtitle
                passwordField
                nextButton
                Spacer()
            }
            .padding()
        }
        .onAppear {
            focusedField = .password
        }
        .toolbarNavigation()
    }
}

//MARK: Subviews
extension CreatePasswordView {
    
    var passwordField: some View {
        TextField("Password", text: $viewModel.username,
                  prompt: Text("Password").foregroundColor(.secondaryBackground), axis: .vertical
        )
        .limitCharacters(text: $viewModel.username, count: AccountServiceDefault.maxUsernameCharCount)
        .focused($focusedField, equals: .password)
        .standardTextField()
        .submitLabel(.next)
    }
    
    var title: some View {
        Text("Create a password")
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var subtitle: some View {
        Text("Create a password that will be difficult to guess.")
            .font(.system(.body, weight: .light))
            .foregroundColor(.primaryText)
    }
    
    var nextButton: some View {
        Button() {
            viewModel.submitPassword()
        } label: {
            Text("Next")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = CreateAccountViewModel(coordinator: coordinator)
    return CreatePasswordView(viewModel: viewModel)
}
