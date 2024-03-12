//
//  AddRuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/24.
//

import SwiftUI

@MainActor
struct AddRuleView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: AddRuleViewModel
    @FocusState private var focusedField: AddRuleField?
    
    var body: some View {
        primaryContent
    }
}

extension AddRuleView {
    var primaryContent: some View {
        UserFormInputView(
            title: viewModel.viewTitle,
            alertModel: $viewModel.alertModel
        ) {
            userInputStack
        }
    }
    
    var userInputStack: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            titleField
            descriptionField
            addResourceButton
            cancelButton
        }
    }
    
    var titleField: some View {
        TitleField(
            title: $viewModel.title,
            focusedField: $focusedField,
            field: AddRuleField.title
        )
        .onSubmit {
            focusedField = .description
        }
    }
    
    var descriptionField: some View {
        DescriptionField(
            description: $viewModel.description,
            focusedField: $focusedField,
            field: AddRuleField.description
        )
        .onSubmit {
            focusedField = nil
            viewModel.submit()
            dismiss()
        }
    }
    
    var addResourceButton: some View {
        Button {
            viewModel.submit()
            dismiss()
        } label: {
            Text(viewModel.submitButtonTitle)
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canSubmit)
    }
    
    var cancelButton: some View {
        Button {
            viewModel.cancelEditingAction()
            dismiss()
        } label: {
            Text("Cancel")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    AddRuleView(viewModel: .preview)
}
