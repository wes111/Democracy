//
//  CreateCommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/3/23.
//

import SwiftUI

enum CreateCommunityField {
    case title, subtitle, body, link, tags
}

struct CreateCommunityView<ViewModel: CreateCommunityViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    @FocusState private var focusedField: CreateCommunityField?
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                viewModel.close()
            } label: {
                Image(systemName: "xmark")
            }
            
            ZStack {
                VStack {
                    Text("Create Community")
                        .font(.title)
                    Form {
                        
                        TextField("Title", text: $viewModel.title)
                            .focused($focusedField, equals: .title)
                            .submitLabel(.next)
                        
                        Button {
                            viewModel.submitCommunity()
                        } label: {
                            Text("Submit")
                        }
                        .disabled(viewModel.isLoading)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
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
    
    func getNextField(after field: CreateCommunityField?) -> CreateCommunityField? {
        guard let field = field else {
            return nil
        }
        switch field {
        case .title: return .subtitle
        case .subtitle: return .body
        case .body: return .link
        case .link: return nil
        case .tags: return nil
        }
    }
}

struct CreateCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCommunityView(viewModel: CreateCommunityViewModel.preview)
    }
}
