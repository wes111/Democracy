//
//  PostTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTagsView: View {
    @Bindable var viewModel: PostTagsViewModel
    
    init(viewModel: PostTagsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            tagsFlow
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Subviews
private extension PostTagsView {
    var tagsFlow: some View {
        ScrollView {
            NewFlowLayout(alignment: .leading) {
                ForEach(viewModel.tags, id: \.self) { tag in
                    tagView(tag)
                }
            }
        }
    }
    
    func tagView(_ tag: String) -> some View {
        let background: Color = viewModel.selectedTags.contains(tag) ? .otherRed : .onBackground
        return Text(tag)
            .tagModifier(backgroundColor: background)
            .onTapGesture {
                viewModel.toggleTag(tag)
            }
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
