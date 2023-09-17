//
//  CreateCommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/3/23.
//

import SwiftUI

enum CreateCommunityField {
    case title, addCategory, body, link, tags
}

//TODO: Remove form since there are many customizations.
struct CreateCommunityView: View {
    
    @StateObject private var viewModel: CreateCommunityViewModel
    @FocusState private var focusedField: CreateCommunityField?
    
    init(viewModel: CreateCommunityViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var titleField: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Title")
                .foregroundStyle(Color.secondaryText)
            
            TextField("", text: $viewModel.title, prompt: Text("Add a title").foregroundColor(.gray))
                .focused($focusedField, equals: .title)
                .submitLabel(.next)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.primaryText, lineWidth: 1)
                )
                .foregroundStyle(Color.secondaryText)
        }
    }
    
    var categoriesField: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Categories")
                .foregroundStyle(Color.secondaryText)
            
            VStack(alignment: .leading, spacing: 20) {
                TextField("Add Category", text: $viewModel.categoryString)
                    .focused($focusedField, equals: .addCategory)
                    .onSubmit {
                        Task {
                            await viewModel.submitCategory()
                        }
                    }
                    .foregroundStyle(Color.secondaryText)
                
                if !viewModel.categories.isEmpty {
                    NewFlowLayout(alignment: .leading) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category)
                                .padding(10)
                                .background(Color.secondaryBackground, in: RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.primaryText, lineWidth: 1)
            )
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.primaryBackground
                .ignoresSafeArea()
            
            Button {
                viewModel.close()
            } label: {
                Image(systemName: "xmark")
            }

            VStack {
                Text("Create Community")
                    .font(.title)
                    .foregroundColor(.secondaryText)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        titleField
                        
                        categoriesField
                        
                        Button {
                            viewModel.submitCommunity()
                        } label: {
                            Text("Submit")
                        }
                        .disabled(viewModel.isLoading)
                        .listRowBackground(Color.secondaryBackground)
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
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
    
    func getNextField(after field: CreateCommunityField?) -> CreateCommunityField? {
        guard let field = field else {
            return nil
        }
        switch field {
        case .title: return .addCategory
        case .addCategory: return .addCategory
        case .body: return .link
        case .link: return nil
        case .tags: return nil
        }
    }
}

//MARK: - Preview
#Preview {
    CreateCommunityView(viewModel: CreateCommunityViewModel.preview)
}
