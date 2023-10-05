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
    
    @ObservedObject var viewModel: CreateAccountViewModel
    @FocusState private var focusedField: CreateUsernameField?
    
    init(viewModel: CreateAccountViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                title
                subtitle
                usernameField
                errors
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
    
    var usernameField: some View {
        TextField("Username", text: $viewModel.username,
                  prompt: Text("Username").foregroundColor(.secondaryBackground), axis: .vertical
        )
        .limitCharacters(text: $viewModel.username, count: UserNameValidation.maxUsernameCharCount)
        .focused($focusedField, equals: .username)
        .standardTextField(borderColor: viewModel.usernameErrors.isEmpty ? .tertiaryText : .otherRed)
        .submitLabel(.next)
    }
    
    var errors: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(viewModel.usernameErrors, id: \.self) { error in
                Label() {
                    Text(error.description)
                        .font(.system(.caption, weight: .light))
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                }
                .foregroundColor(.otherRed)
            }
        }
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
            viewModel.submitUsername()
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
