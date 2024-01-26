//
//  UserTextEditorInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct UserTextEditorInputView<ViewModel: UserTextEditorInputViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState.Binding var focusedField: ViewModel.Field?
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField) {
                primaryContent
            }
    }
}

// MARK: - Subviews
private extension UserTextEditorInputView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            picker
            tabView
        }
    }
    
    var picker: some View {
        CustomPicker(
            title: "Picker",
            selection: $viewModel.selectedTab) {
                ForEach(PostBodyTab.allCases, id: \.self) { tab in
                    Text(tab.rawValue.capitalized).tag(tab)
                }
            }
    }
    
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                field: viewModel.field,
                text: $viewModel.text,
                focusedField: $focusedField
            )
    }
    
    var userPreview: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                Text(viewModel.markdown)
                    .foregroundStyle(Color.tertiaryText)
                    .lineLimit(nil)
                    .padding(.horizontal, 22.5)
                    .padding(.vertical, 25.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var tabView: some View {
        TabView(selection: $viewModel.selectedTab) {
            field
                .tag(PostBodyTab.editor)
            
            userPreview
                .tag(PostBodyTab.preview)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeOut(duration: 0.2), value: viewModel.selectedTab)
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: SubmitPostField?
    
    let viewModel = PostBodyViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return NavigationStack {
        UserTextEditorInputView(
            viewModel: viewModel,
            focusedField: $focusedField
        )
    }
}