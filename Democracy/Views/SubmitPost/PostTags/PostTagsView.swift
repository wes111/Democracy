//
//  PostTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTagsView: View {
    @ObservedObject var viewModel: PostTagsViewModel
    
    init(viewModel: PostTagsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    title
                    
                    tagsFlow
                        .titledElement(title: viewModel.subtitle)
                }
                nextButton
            }
            .padding(ViewConstants.screenPadding)
            
            if viewModel.isShowingProgress {
                CustomProgressView()
            }
        }
        .toolbarNavigation(
            leadingButtons: [.back],
            trailingButtons: [.close(viewModel.close)]
        )
    }
}

// MARK: - Subviews
private extension PostTagsView {
    
    // Note: This matches the title in UserInputView.
    var title: some View {
        Text(viewModel.title)
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
    
    var tagsFlow: some View {
        ScrollView {
            NewFlowLayout(alignment: .leading) {
                ForEach(viewModel.selectableTags) { tag in
                    let tagBackgroundColor: Color = tag.isSelected ? .otherRed : .secondaryBackground
                    Text(tag.tag.name)
                        .padding(10)
                        .background(tagBackgroundColor, in: RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.secondaryText)
                        .onTapGesture {
                            viewModel.toggleTag(tag)
                        }
                }
            }
        }
    }
    
    var nextButton: some View {
        AsyncButton(
            action: { await viewModel.submit() },
            label: { Text("Next") },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.canSubmit)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTagsViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    
    return NavigationStack {
        PostTagsView(viewModel: viewModel)
    }
}
