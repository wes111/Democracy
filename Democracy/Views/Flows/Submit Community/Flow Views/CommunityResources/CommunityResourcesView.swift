//
//  CommunityLeadersView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunityResourcesView: View {
    @Bindable var viewModel: CommunityResourcesViewModel
    
    var body: some View {
        primaryContent
            .fullScreenCover(isPresented: $viewModel.isShowingAddResourceSheet) {
                AddResourceView(viewModel: viewModel.addResourceViewModel())
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
            .animation(.easeInOut, value: viewModel.isShowingAddResourceSheet)
            .onAppear {
                viewModel.onAppear()
            }
            .dismissKeyboardOnDrag()
    }
}

// MARK: - Subviews
private extension CommunityResourcesView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            addedResources
            Spacer()
            addResourceButton
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
    var addedResources: some View {
        SnappingHorizontalScrollView(scrollContent: viewModel.resources) { resource in
            MenuCard(
                title: resource.title,
                description: resource.description,
                image: resource.category.image) {
                    Button("Delete") { viewModel.removeResource(resource) }
                    Button("Edit") { viewModel.editResource(resource) }
                }
        }
    }
    
    var addResourceButton: some View {
        Button {
            viewModel.isShowingAddResourceSheet = true
        } label: {
            Text("Add Resource")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityResourcesView(viewModel: .preview)
    }
}
