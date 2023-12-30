//
//  PostTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct SelectableTag: Identifiable {
    let tag: Tag
    var isSelected: Bool
    let id: String
    
    init(tag: Tag, isSelected: Bool = false) {
        self.tag = tag
        self.isSelected = isSelected
        id = tag.id
    }
}

struct PostTagsView: View {
    @ObservedObject var viewModel: PostTagsViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    init(viewModel: PostTagsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserInputView(
            viewModel: viewModel,
            content: { field }
        )
        .onAppear {
            focusedField = viewModel.field
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

// MARK: - Subviews
private extension PostTagsView {
    
    var field: some View {
        ScrollView {
            NewFlowLayout(alignment: .leading) {
                ForEach(viewModel.selectableTags) { tag in
                    let tagBackgroundColor: Color = tag.isSelected ? .otherRed : .secondaryBackground
                    Button {
                        viewModel.toggleTag(tag)
                    } label: {
                        Text(tag.tag.name)
                            .padding(10)
                            .background(tagBackgroundColor, in: RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(Color.secondaryText)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTagsViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return PostTagsView(viewModel: viewModel)
}
