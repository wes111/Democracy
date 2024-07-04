//
//  ResourceView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/5/23.
//

import SwiftUI

struct ResourceView: View {
    
    var viewModel: ResourceViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(viewModel.index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(.tertiaryText)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(.init(viewModel.linkTitle))
                    .font(.bold(.body)())
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
}

//// MARK: - Preview
//#Preview {
//    let viewModel = Resource.previewArray.first!.viewModel(index: 0)
//    return ResourceView(viewModel: viewModel)
//}
