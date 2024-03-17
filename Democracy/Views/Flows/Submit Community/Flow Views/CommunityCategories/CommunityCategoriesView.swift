//
//  CommunityCategoriesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunityCategoriesView<ViewModel: CommunityCategoriesViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
    }
}

// MARK: - Subviews
extension CommunityCategoriesView {
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                field
                VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                    addCategoryButton
                    scrollInput
                    Spacer()
                    SubmittableNextButton(viewModel: viewModel)
                }
            }
        }
    }
    
    var addCategoryButton: some View {
        Button {
            viewModel.submit()
        } label: {
            Text("Add Category")
        }
        .buttonStyle(SeconaryButtonStyle())
        .disabled(viewModel.text.isEmpty)
    }
    
    var scrollInput: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                ForEach(viewModel.categories, id: \.self) { category in
                    categoryView(category)
                }
            }
            .animation(.easeOut(duration: ViewConstants.animationLength), value: viewModel.categories)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func categoryView(_ category: String) -> some View {
        HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
            Text(category)
            
            Spacer()
            
            Button {
                viewModel.removeCategory(category)
            } label: {
                Image(systemName: SystemImage.xCircle.rawValue)
            }
        }
        .selectableModifier()
    }
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .categories
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: CommunityCategoriesViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityCategoriesView(viewModel: .preview)
    }
}
