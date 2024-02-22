//
//  AddResourceView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import SwiftUI

// Text fields of the AddResourceView
enum AddResourceField: Hashable {
    case title, description, url
}

@MainActor
struct AddResourceView: View {
    @Bindable var viewModel: AddResourceViewModel
    @FocusState private var focusedField: AddResourceField?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack { // Remove if this view needs navigation beyond closing.
            primaryContent
                .toolbarNavigation(
                    trailingButtons: [.close({ dismiss() })]
                )
                .background(Color.primaryBackground.ignoresSafeArea())
                .alert(item: $viewModel.alertModel) { alert in
                    Alert(
                        title: Text(alert.title),
                        message: Text(alert.description),
                        dismissButton: .default(Text("Okay"))
                    )
                }
        }
    }
}

// MARK: - Subviews
private extension AddResourceView {
    
    var primaryContent: some View {
        ZStack(alignment: .center) {
            // The GeometryReader here prevents the view from moving
            // with keyboard appearance/disappearance.
            GeometryReader { _ in
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                        UserInputTitle(title: "Add Community Resource")
                        userInputStack
                    }
                    .padding(ViewConstants.screenPadding)
                }
                .clipped()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
    
    var userInputStack: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            HorizontalSelectableList(selection: $viewModel.category)
                .titledElement(title: "Category")
            
            titleField
            urlField
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
            Text("Add Resource")
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canSubmit)
    }
    
    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
    
    var titleField: some View {
        DefaultTextInputField(
            text: $viewModel.title,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.title,
                focusedField: $focusedField,
                field: AddResourceField.title
            ),
            fieldTitle: "Title",
            requirementType: DefaultRequirement.self
        )
        .titledElement(title: "Title")
        .onSubmit {
            focusedField = .description
        }
    }
    
    var urlField: some View {
        DefaultTextInputField(
            text: $viewModel.url,
            textFieldStyle: LinkTextFieldStyle(
                link: $viewModel.url,
                focusedField: $focusedField,
                field: .url
            ),
            fieldTitle: "URL",
            requirementType: LinkRequirement.self
        )
        .titledElement(title: "Link")
        .onSubmit {
            focusedField = .description
        }
    }
    
    var descriptionField: some View {
        TextField(
            "Description",
            text: $viewModel.description,
            prompt: Text("Description").foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .lineLimit(3...4)
        .requirements(
            text: $viewModel.description,
            requirementType: DefaultRequirement.self
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: $viewModel.description,
            focusedField: $focusedField,
            field: AddResourceField.description
        ))
        .titledElement(title: "Description")
        .onSubmit {
            focusedField = .title
        }
    }
}

// MARK: - Preview
#Preview {
    AddResourceView(viewModel: .preview)
}
