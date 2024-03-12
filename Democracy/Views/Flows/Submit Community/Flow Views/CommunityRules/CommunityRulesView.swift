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
    
    init(viewModel: CommunityRulesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        primaryContent
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
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
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
    
    // TODO: There should be a better way to handle nil here...
    var addRuleSheet: some View {
        Group {
            if let viewModel = viewModel.addRuleViewModel() {
                AddRuleView(viewModel: viewModel)
            } else {
                EmptyView()
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
