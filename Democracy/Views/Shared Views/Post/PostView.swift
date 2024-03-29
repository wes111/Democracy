//
//  PostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

struct PostView<ViewModel: PostViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("This is a post's main view.")
        }
    }
    
}

// MARK: - Preview
#Preview {
    PostView(viewModel: GARBAGEPostViewModel.preview)
}
