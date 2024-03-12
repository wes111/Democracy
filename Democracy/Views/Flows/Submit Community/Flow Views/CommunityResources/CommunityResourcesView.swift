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
                addResourceSheet
            }
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
            addResourceButton
            Spacer()
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
    
    // TODO: Should be a better way to handle nil here
    var addResourceSheet: some View {
        Group {
            if let viewModel = viewModel.addResourceViewModel() {
                AddResourceView(viewModel: viewModel)
            } else {
                EmptyView()
            }
        }
        
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityResourcesView(viewModel: .preview)
    }
}
