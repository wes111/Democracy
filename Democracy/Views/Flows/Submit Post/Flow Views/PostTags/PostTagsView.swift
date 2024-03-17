//
//  PostTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

@MainActor
struct PostTagsView: View {
    @Bindable var viewModel: PostTagsViewModel
    
    init(viewModel: PostTagsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
    }
}

// MARK: - Subviews
private extension PostTagsView {
    
    var primaryContent: some View {
        VStack {
            tagsFlow
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
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
    NavigationStack {
        PostTagsView(viewModel: .preview)
    }
}
