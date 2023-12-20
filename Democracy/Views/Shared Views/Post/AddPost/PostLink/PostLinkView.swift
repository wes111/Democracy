//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostLinkView: View {
    
    @ObservedObject var viewModel: PostLinkViewModel
    //@FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PostLinkViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostLinkViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostLinkView(viewModel: viewModel)
}
