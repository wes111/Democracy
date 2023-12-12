//
//  ResourceSection.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/5/23.
//

import SwiftUI

struct ResourcesSection: View {
    
    let viewModel: ResourcesSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.title)
                .font(.title)
            
            ForEach(viewModel.resourceViewModels) { resource in
                VStack {
                    ResourceView(viewModel: resource)
                    Divider()
                        .overlay(Color.tertiaryBackground)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = ResourcesSectionViewModel(
        title: "Resources",
        resources: Resource.previewArray
    )
    return ResourcesSection(viewModel: viewModel)
}
