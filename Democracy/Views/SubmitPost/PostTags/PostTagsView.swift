//
//  PostTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTagsView: View {
    
    @ObservedObject var viewModel: PostTagsViewModel
    // @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PostTagsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTagsViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostTagsView(viewModel: viewModel)
}
