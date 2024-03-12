//
//  CommunityTagsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunityTagsView<ViewModel: CommunityTagsViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
    }
}

// MARK: - Subviews
private extension CommunityTagsView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel) {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                field
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    addTagButton
                    scrollInput
                    Spacer()
                    SubmittableNextButton(viewModel: viewModel)
                }
            }
        }
    }
    
    var addTagButton: some View {
        Button {
            viewModel.submit()
        } label: {
            Text("Add Tag")
        }
        .buttonStyle(SeconaryButtonStyle())
        .disabled(viewModel.text.isEmpty)
    }
    
    var scrollInput: some View {
        ScrollView {
            NewFlowLayout {
                ForEach(viewModel.tags, id: \.self) { tag in
                    tagView(tag)
                }
            }
            .frame(maxWidth: .infinity)
            .animation(.easeOut(duration: ViewConstants.animationLength), value: viewModel.tags)
        }
    }
    
    func tagView(_ tag: String) -> some View {
        HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
            Text(tag)
            
            Button {
                viewModel.removeTag(tag)
            } label: {
                Image(systemName: SystemImage.xCircle.rawValue)
            }
        }
        .tagModifier()
            
    }
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .tags
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: CommunityTagsViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityTagsView(viewModel: .preview)
    }
}
