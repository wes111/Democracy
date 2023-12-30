//
//  CreateCommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/3/23.
//

import SwiftUI

enum CreateCommunityField {
    case title, addCategory, summary
}

struct CreateCommunityView: View {
    @StateObject private var viewModel: CreateCommunityViewModel
    @FocusState private var focusedField: CreateCommunityField?
    
    init(viewModel: CreateCommunityViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.primaryBackground
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    titleField
                    summaryField
                    categoriesField
                    adultContentCheckBox
                    submitButton
                }
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .toolbarNavigation(
            leadingButtons: viewModel.leadingButtons,
            trailingButtons: viewModel.trailingButtons
        )
        .onAppear {
            focusedField = .title
        }
        .onSubmit {
            focusedField = getNextField(after: focusedField)
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
        }
    }
}

// MARK: - Subviews
extension CreateCommunityView {
    
    var summaryField: some View {
        TextField(
            "Summary",
            text: $viewModel.summary,
            prompt: Text("Describe the community").foregroundColor(.secondaryBackground),
            axis: .vertical
        )
        .limitCharacters(text: $viewModel.categoryString, count: 2_000)
        .lineLimit(3...10)
        .focused($focusedField, equals: .summary)
        // .standardTextInputAppearance()
    }
    
    var titleField: some View {
        TextField(
            "",
            text: $viewModel.title,
            prompt: Text("Add a title").foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .limitCharacters(text: $viewModel.title, count: 75)
        .lineLimit(2)
        .focused($focusedField, equals: .title)
        // .standardTextInputAppearance()
        .submitLabel(.next)
    }
    
    var categoriesField: some View {
        TextField(
            "Add Category",
            text: $viewModel.categoryString,
            prompt: Text("Add a post category").foregroundColor(.tertiaryBackground)
        )
        .taggable(tags: viewModel.categories)
        .limitCharacters(text: $viewModel.categoryString, count: 25)
        .focused($focusedField, equals: .addCategory)
        .onSubmit {
            Task {
                await viewModel.submitCategory()
            }
        }
    }
    
    var submitButton: some View {
        Button {
            viewModel.submitCommunity()
        } label: {
            Text("Submit")
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(viewModel.isLoading)
    }
    
    var adultContentCheckBox: some View {
        Toggle(isOn: $viewModel.hasAdultContent) {
            Text("Adult Content 18+")
        }
        .toggleStyle(.iOSCheckbox)
    }
}

// MARK: - Helper Methods
extension CreateCommunityView {
    
    func getNextField(after field: CreateCommunityField?) -> CreateCommunityField? {
        guard let field = field else {
            return nil
        }
        switch field {
        case .title: return .summary
        case .summary: return .addCategory
        case .addCategory: return .addCategory
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CreateCommunityView(viewModel: CreateCommunityViewModel.preview)
    }
    
}
