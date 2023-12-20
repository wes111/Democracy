//
//  PostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostBodyView: View {
    @ObservedObject var viewModel: PostBodyViewModel
    //@FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PostBodyViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    let viewModel = PostBodyViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostBodyView(viewModel: viewModel)
}
