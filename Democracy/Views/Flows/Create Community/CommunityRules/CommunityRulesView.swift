//
//  CommunityRulesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunityRulesView: View {
    @Bindable var viewModel: CommunityRulesViewModel
    @FocusState private var focusedField: CommunityRulesField?
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            primaryContent
        }
        .onAppear {
            focusedField = .title
            viewModel.onAppear()
        }
        .dismissKeyboardOnDrag()
    }
}

// MARK: - Subviews
private extension CommunityRulesView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                titleField
                descriptionField
                addRuleButton
            }
            
            scrollContent()
        }
    }
    
    var titleField: some View {
        DefaultTextInputField(
            text: $viewModel.ruleTitle,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.ruleTitle,
                focusedField: $focusedField,
                field: CommunityRulesField.title
            ),
            fieldTitle: CommunityRulesField.title.fieldTitle,
            requirementType: DefaultRequirement.self
        )
        .onSubmit {
            focusedField = .description
        }
    }
    
    var descriptionField: some View {
        TextField(
            CommunityRulesField.description.fieldTitle,
            text: $viewModel.ruleDescription,
            prompt: Text(CommunityRulesField.description.fieldTitle).foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .lineLimit(2...2)
        .requirements(
            text: $viewModel.text,
            requirementType: DefaultRequirement.self
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: $viewModel.ruleDescription,
            focusedField: $focusedField,
            field: CommunityRulesField.description
        ))
        .onSubmit {
            viewModel.submit()
            focusedField = .title
        }
    }
    
    var addRuleButton: some View {
        Button {
            viewModel.submit()
        } label: {
            Text("Add Rule")
        }
        .buttonStyle(SeconaryButtonStyle())
        .disabled(viewModel.isMissingContent)
    }
    
    func scrollContent() -> some View {
        SnappingHorizontalScrollView(scrollContent: viewModel.rules) { rule in
            MenuCard(
                title: rule.title,
                description: rule.description,
                image: .exclamationmarkTriangle
            ) {
                Button("Delete") { viewModel.removeRule(rule) }
                Button("Edit") { viewModel.editRule(rule) }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityRulesView(viewModel: .preview)
    }
}
