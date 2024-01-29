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
            }
            addRuleButton
            scrollContent
        }
    }
    
    var scrollContent: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                ForEach(viewModel.rules, id: \.self) { rule in
                    ruleView(rule)
                        .containerRelativeFrame(.horizontal)
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func ruleView(_ rule: Rule) -> some View {
        RuleView(rule: rule) {
            Button("Delete") { viewModel.removeRule(rule) }
            Button("Edit") { viewModel.editRule(rule) }
            Button("Show Expanded") { viewModel.showExpandedRule(rule) }
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
        DefaultTextInputField(
            text: $viewModel.ruleDescription,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.ruleDescription,
                focusedField: $focusedField,
                field: CommunityRulesField.description
            ),
            fieldTitle: CommunityRulesField.description.fieldTitle,
            requirementType: DefaultRequirement.self
        )
        .lineLimit(2...10)
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
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityRulesView(viewModel: .preview)
    }
}
