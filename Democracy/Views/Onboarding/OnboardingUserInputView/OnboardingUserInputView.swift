//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

struct OnboardingUserInputView<T: ValidatableOnboardingField>: View {
    @ObservedObject var viewModel: OnboardingUserInputViewModel<T>
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: OnboardingUserInputViewModel<T>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        EmptyView()
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                title
                subtitle
                field
                errors
                nextButton
                Spacer()
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
            }
        }
        .onAppear {
            focusedField = T.field
        }
        .toolbarNavigation(topButtons: viewModel.topButtons)
        .onTapGesture {
            focusedField = nil //TODO: I don't think this quite works.
        }
        .alert(item: $viewModel.onboardingAlert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Okay")))
        }
        .task {
            await viewModel.resetTextField()
        }
    }
}

//MARK: Subviews
extension OnboardingUserInputView {
    
    var field: some View {
        TextField(viewModel.fieldTitle, text: $viewModel.text,
                  prompt: Text(viewModel.fieldTitle).foregroundColor(.secondaryBackground), axis: .vertical
        )
        .limitCharacters(text: $viewModel.text, count: viewModel.maxCharacterCount)
        .focused($focusedField, equals: T.field)
        .standardTextField(borderColor: viewModel.textErrors.isEmpty ? .tertiaryText : .otherRed)
        .submitLabel(.next)
    }
    
    var errors: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(viewModel.textErrors, id: \.self) { error in
                Label() {
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
    }
    
    var nextButton: some View {
        Button() {
            Task {
                await viewModel.submit()
            }
        } label: {
            Text("Next")
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canSubmit)
    }
}

//MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = OnboardingUserInputViewModel<UsernameValidator>(coordinator: coordinator)
    return OnboardingUserInputView(viewModel: viewModel)
}
