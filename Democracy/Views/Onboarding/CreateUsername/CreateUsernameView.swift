//
//  CreateUsernameView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import SwiftUI

enum CreateUsernameField {
    case username
}

struct CreateUsernameView: View {
    
    @StateObject var viewModel: CreateAccountViewModel
    @FocusState private var focusedField: CreateUsernameField?
    @State var appeared: Double = 0
    
    init(viewModel: CreateAccountViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
            focusedField = .username
        }
        .toolbarNavigation()
    }
}

//MARK: Subviews
extension CreateUsernameView {
    
    var passwordField: some View {
        TextField("Username", text: $viewModel.username,
                  prompt: Text("Username").foregroundColor(.secondaryBackground), axis: .vertical
        )
        .limitCharacters(text: $viewModel.username, count: AccountServiceDefault.maxUsernameCharCount)
        .focused($focusedField, equals: .username)
        .standardTextField()
        .submitLabel(.next)
    }
    
    var title: some View {
        Text("Create a username")
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var subtitle: some View {
        Text("Create a unique username as a unique identifier across the app.")
            .font(.system(.body, weight: .light))
            .foregroundColor(.primaryText)
    }
    
    var nextButton: some View {
        Button() {
            viewModel.goToNext()
        } label: {
            Text("Next")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

//MARK: - Preview
#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = CreateAccountViewModel(coordinator: coordinator)
    return CreateUsernameView(viewModel: viewModel)
}
