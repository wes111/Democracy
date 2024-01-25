//
//  PostSuccessView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import SwiftUI

struct PostSuccessView: View {
    @ObservedObject private var viewModel: PostSuccessViewModel
    private let primaryString = "Your post has been submitted!"
    private let secondaryString = """
    Your post has been submitted and is currently under review. \
    Once approved, your post will be visible to the entire community.
    """
    
    init(viewModel: PostSuccessViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SuccessView(
            primaryText: Text(primaryString),
            secondaryText: Text(secondaryString),
            image: Image(systemName: "checkmark.diamond.fill"),
            primaryButtonInfo: viewModel.primaryButtonInfo,
            secondaryButtonInfo: nil
        )
        .toolbarNavigation(trailingButtons: viewModel.trailingButtons)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostSuccessViewModel(coordinator: SubmitPostCoordinator.preview)
    return NavigationStack {
        PostSuccessView(viewModel: viewModel)
    }
}
