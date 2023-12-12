//
//  CreateCandidateView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/27/23.
//

import SwiftUI

enum CreateCandidateField {
    case summary, link
}

struct CreateCandidateView<ViewModel: CreateCandidateViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    @FocusState private var focusedField: CreateCandidateField?
    
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
                    Text("Create Candidate View")
                        .font(.title)
                    Form {
                        TextField("Summary", text: $viewModel.summary)
                            .focused($focusedField, equals: .summary)
                            .submitLabel(.next)
                        
                        TextField("External Link", text: $viewModel.link)
                            .focused($focusedField, equals: .link)
                            .submitLabel(.next)
                        
                        Button {
                            focusedField = nil
                            viewModel.submitCandidate()
                        } label: {
                            Text("Submit")
                        }
                        .disabled(viewModel.isLoading)
                        
                        Picker("Choose a rep type", selection: $viewModel.repType) {
                            ForEach(RepresentativeType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .onAppear {
            focusedField = .summary
        }
        .onSubmit {
            focusedField = getNextField(after: focusedField)
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
        }
    }
    
    func getNextField(after field: CreateCandidateField?) -> CreateCandidateField? {
        guard let field = field else {
            return nil
        }
        switch field {
        case .summary: return .link
        case .link: return nil
        }
    }
    
}

// MARK: - Preview
#Preview {
    CreateCandidateView(viewModel: CreateCandidateViewModel.preview)
}
