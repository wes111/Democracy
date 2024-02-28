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
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            primaryContent
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAddRuleSheet) {
            addRuleSheet
        }
        .animation(.easeInOut, value: viewModel.isShowingAddRuleSheet)
        .onAppear {
            viewModel.onAppear()
        }
        .dismissKeyboardOnDrag()
    }
}

// MARK: - Subviews
private extension CommunityRulesView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            scrollContent()
            addRuleButton
        }
    }
    
    var addRuleButton: some View {
        Button {
            viewModel.isShowingAddRuleSheet = true
        } label: {
            Text("Add Rule")
        }
        .buttonStyle(SeconaryButtonStyle())
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
    
    var addRuleSheet: some View {
        AddRuleView(viewModel: viewModel.addRuleViewModel())
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityRulesView(viewModel: .preview)
    }
}
