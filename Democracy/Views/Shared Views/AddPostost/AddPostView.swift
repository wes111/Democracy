//
//  CreatePostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import SwiftUI

struct AddPostView<ViewModel: AddPostViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel

    @FocusState private var focusedField: PostField?
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Create Post")
                .font(.title)
            Form {
                TextField("Title", text: $viewModel.title)
                    .focused($focusedField, equals: .title)
                    .submitLabel(.next)
                
                TextField("Subtitle", text: $viewModel.subtitle)
                    .focused($focusedField, equals: .title)
                    .submitLabel(.next)
                
                TextField("Body", text: $viewModel.body)
                    .focused($focusedField, equals: .title)
                    .submitLabel(.next)
                
                TextField("Link", text: $viewModel.link)
                    .focused($focusedField, equals: .title)
                    .submitLabel(.next)
                
                Button {
                    viewModel.submitPost()
                } label: {
                    Text("Submit")
                }
            }
        }

        .onAppear {
            focusedField = .title
        }
        .onSubmit {
            focusedField = getNextField(after: focusedField)
        }
    }
    
    func getNextField(after field: PostField?) -> PostField? {
        guard let field = field else {
            return nil
        }
        switch field {
        case .title: return .subtitle
        case .subtitle: return .body
        case .body: return .link
        case .link: return .tags
        case .tags: return nil
        }
    }
    
    
}



struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(viewModel: AddPostViewModel.preview)
    }
}
