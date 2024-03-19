//
//  UserTextEditorInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct SubmittableTextEditorInputView<ViewModel: SubmittableTextEditorInputViewModel, Field: View>: View {
    @Bindable var viewModel: ViewModel
    @FocusState.Binding var focusedField: ViewModel.FocusedField?
    @ViewBuilder let field: Field
    
    init(
        viewModel: ViewModel,
        focusedField: FocusState<ViewModel.FocusedField?>.Binding,
        @ViewBuilder field: () -> Field
    ) {
        self.viewModel = viewModel
        self._focusedField = focusedField
        self.field = field()
    }
    
    var body: some View {
        primaryContent
    }
}

// MARK: - Subviews
private extension SubmittableTextEditorInputView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                picker
                tabView
            }
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
    @FocusState var focusedField: PostFlow.ID?
    
    return NavigationStack {
        SubmittableTextEditorInputView(viewModel: PostBodyViewModel.preview, focusedField: $focusedField) {
            EmptyView()
        }
    }
}
