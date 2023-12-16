//
//  CreatePostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import SwiftUI

enum PostField {
    case title, subtitle, body, link, tags
}

extension View {
    func defaultBackground() -> some View {
        modifier(DefaultBackgroundModifier())
    }
}

struct DefaultBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            content
        }
    }
}

struct AddPostView: View {
    
    @StateObject private var viewModel: AddPostViewModel
    @FocusState private var focusedField: PostField?
    
    init(viewModel: AddPostViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            EmptyView()
        }
//        ZStack(alignment: .topTrailing) {
//            Button {
//                viewModel.close()
//            } label: {
//                Image(systemName: "xmark")
//            }
//            
//            ZStack {
//                VStack {
//                    Text("Create Post")
//                        .font(.title)
//                }
//                
//                if viewModel.isLoading {
//                    ProgressView()
//                }
//            }
//        }
        .defaultBackground()
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
    
    func getNextField(after field: PostField?) -> PostField? {
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

// MARK: - Preview
#Preview {
    AddPostView(viewModel: AddPostViewModel.preview)
}
