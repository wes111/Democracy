//
//  AddResourceView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import SwiftUI

@MainActor
struct AddResourceView: View {
    @Bindable var viewModel: AddResourceViewModel
    @FocusState private var focusedField: AddResourceField?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        primaryContent
    }
}

// MARK: - Subviews
private extension AddResourceView {
    
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
            HorizontalSelectableList(selection: $viewModel.category)
                .titledElement(title: "Category")
            
            titleField
            linkField
            descriptionField
            addResourceButton
            cancelButton
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
    
    var titleField: some View {
        TitleField(
            title: $viewModel.title,
            focusedField: $focusedField,
            field: AddResourceField.title
        )
        .onSubmit {
            focusedField = .link
        }
    }
    
    var linkField: some View {
        LinkField(
            link: $viewModel.url,
            focusedField: $focusedField,
            field: AddResourceField.link
        )
        .onSubmit {
            focusedField = .description
        }
    }
    
    var descriptionField: some View {
        DescriptionField(
            description: $viewModel.description,
            focusedField: $focusedField,
            field: AddResourceField.description
        )
        .onSubmit {
            focusedField = nil
            viewModel.submit()
            dismiss()
        }
    }
}

// MARK: - Preview
#Preview {
    AddResourceView(viewModel: .preview)
}
