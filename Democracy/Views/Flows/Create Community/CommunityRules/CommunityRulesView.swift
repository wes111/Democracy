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
private extension CommunityRulesView {
    
    func scrollContent(ruleSize: RuleViewSize) -> some View {
        GeometryReader { geo in
            let ruleWidth = geo.size.width * 0.75
            let padding: CGFloat = 5.0
            let totalWidth = ruleWidth + padding * 2
            
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(viewModel.rules, id: \.self) { rule in
                        ruleView(rule, size: ruleSize)
                            .padding(.horizontal, padding)
                            .frame(width: totalWidth)
                            
                            .scrollTransition(.animated.threshold(.visible(0.5))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.5)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                    .blur(radius: phase.isIdentity ? 0 : 1)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, (geo.size.width - totalWidth) / 2, for: .scrollContent)
            .frame(maxHeight: .infinity)
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
            .scrollIndicators(.hidden)
        }

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
