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
        UserSelectionView(viewModel: viewModel) {
            tagsFlow
        }
    }
}

// MARK: - Subviews
private extension PostTagsView {
    var tagsFlow: some View {
        ScrollView {
            NewFlowLayout(alignment: .leading) {
                ForEach(viewModel.tags) { tag in
                    tagView(tag)
                }
            }
        }
    }
    
    func tagView(_ tag: Tag) -> some View {
        let backgroundColor: Color = viewModel.selectedTags.contains(tag) ? .otherRed : Color.white.opacity(0.1)
        
        return Text(tag.name)
            .padding(ViewConstants.smallInnerBorder)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
            .foregroundStyle(Color.secondaryText)
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
