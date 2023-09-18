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

//TODO: Add adult content checkbox.
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
                VStack(alignment: .leading, spacing: 20) {
                    titleField
                    summaryField
                    categoriesField
                    submitButton
                }
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Create Community")
                        .font(.headline)
                        .foregroundColor(.tertiaryText)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.close()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.tertiaryText)
                }
            }
        }
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

//MARK: - Subviews
extension CreateCommunityView {
    
    var summaryField: some View {
        TextField("Summary", text: $viewModel.summary, axis: .vertical)
            .lineLimit(3...10)
            .standardTextField(title: "Summary")
    }
    
    var titleField: some View {
        TextField("", text: $viewModel.title, prompt: Text("Add a title"), axis: .vertical)
            .lineLimit(2)
            .standardTextField(title: "Title")
            .focused($focusedField, equals: .title)
            .submitLabel(.next)
    }
    
    var categoriesField: some View {
        TextField("Add Category", text: $viewModel.categoryString)
            .taggable(title: "Categories", tags: viewModel.categories)
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
}

//MARK: - Helper Methods
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

//MARK: - Preview
#Preview {
    NavigationStack {
        CreateCommunityView(viewModel: CreateCommunityViewModel.preview)
    }
    
}
