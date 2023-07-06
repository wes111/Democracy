//
//  ResourceSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/5/23.
//

import Foundation

struct ResourcesSectionViewModel {
    
    let title: String
    private let resources: [Resource]
    let resourceViewModels: [ResourceViewModel]
    
    init(
        title: String,
        resources: [Resource]
    ) {
        self.title = title
        self.resources = resources
        
        resourceViewModels = {
            var viewModels: [ResourceViewModel] = []
            for (index, resource) in resources.enumerated() {
                viewModels.append(resource.viewModel(index: index))
            }
            return viewModels
        }()
    }
}
