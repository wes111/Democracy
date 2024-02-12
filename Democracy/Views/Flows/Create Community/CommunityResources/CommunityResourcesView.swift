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
        UserInputScreen(viewModel: viewModel) {
            primaryContent
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAddResourceSheet) {
            addResourceSheet
        }
        .animation(.easeInOut, value: viewModel.isShowingAddResourceSheet)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Subviews
private extension CommunityResourcesView {
    
    var primaryContent: some View {
        VStack {
            addResourceButton
            // TODO: ...
            SnappingHorizontalScrollView(scrollContent: ["hello world"]) { text in
                Text(text)
            }
            
            ForEach(viewModel.resources, id: \.self) { resource in
                Text(resource.title)
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
    
    var addResourceSheet: some View {
        AddResourceView(viewModel: viewModel.addResourceViewModel())
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityResourcesView(viewModel: .preview)
    }
    
}
