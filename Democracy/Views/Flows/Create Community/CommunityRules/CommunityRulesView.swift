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
    @FocusState private var focusedField: CreateCommunityField?
    
    let titleFieldTitle = CreateCommunityField.ruleTitle.fieldTitle
    let descriptionFieldTitle = CreateCommunityField.ruleDescription.fieldTitle
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            primaryContent
        }
        .onAppear {
            focusedField = .ruleTitle
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
        TextField(
            titleFieldTitle,
            text: $viewModel.ruleTitle,
            prompt: Text(titleFieldTitle).foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: $viewModel.ruleTitle,
            focusedField: $focusedField,
            field: CreateCommunityField.ruleTitle
        ))
        .requirements(
            text: $viewModel.ruleTitle,
            requirementType: NoneRequirement.self,
            field: CreateCommunityField.ruleTitle
        )
        .onSubmit {
            focusedField = .ruleDescription
        }
    }
    
    var descriptionField: some View {
        TextField(
            descriptionFieldTitle,
            text: $viewModel.ruleDescription,
            prompt: Text(descriptionFieldTitle).foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .lineLimit(2...10)
        .textFieldStyle(TitleTextFieldStyle(
            title: $viewModel.ruleDescription,
            focusedField: $focusedField,
            field: CreateCommunityField.ruleDescription
        ))
        .requirements(
            text: $viewModel.ruleDescription,
            requirementType: NoneRequirement.self,
            field: CreateCommunityField.ruleDescription
        )
        .onSubmit {
            viewModel.submit()
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
