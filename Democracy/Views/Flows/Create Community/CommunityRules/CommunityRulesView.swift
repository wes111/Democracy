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
        .animation(.easeOut(duration: ViewConstants.animationLength), value: viewModel.rules)
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
            ViewThatFits(in: .vertical) {
                scrollContent(ruleSize: .medium)
                scrollContent(ruleSize: .small)
            }
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
        .lineLimit(2...4)
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
}

// MARK: Scroll Content Subviews
// Note: Hack-ish solution
private extension CommunityRulesView {
    func contentMargins(ruleSize: RuleViewSize) -> CGFloat {
        switch ruleSize {
        case .small:
            40
        case .medium:
            25
        }
    }
    
    func frameWidth(ruleSize: RuleViewSize) -> CGFloat {
        switch ruleSize {
        case .small:
            250
        case .medium:
            300
        }
    }
    
    func scrollContent(ruleSize: RuleViewSize) -> some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(viewModel.rules, id: \.self) { rule in
                    ruleView(rule, size: ruleSize)
                        .frame(width: frameWidth(ruleSize: ruleSize))
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, contentMargins(ruleSize: ruleSize))
        .scrollTargetBehavior(.viewAligned)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func ruleView(_ rule: Rule, size: RuleViewSize) -> some View {
        RuleView(rule: rule, size: size) {
            Button("Delete") { viewModel.removeRule(rule) }
            Button("Edit") { viewModel.editRule(rule) }
            Button("Show Expanded") { viewModel.showExpandedRule(rule) }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityRulesView(viewModel: .preview)
    }
}
