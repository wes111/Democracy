//
//  AddPostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import Combine
import Factory

protocol AddPostCoordinatorDelegate: AnyObject {
    func close()
}

protocol AddPostViewModelProtocol: ObservableObject {
    var title: String { get set }
    var subtitle: String { get set }
    var body: String { get set }
    var link: String { get set }
    
    var alert: AddPostAlert? { get set }
    var isLoading: Bool { get set }
    
    func close()
    func submitPost()
}

final class AddPostViewModel: AddPostViewModelProtocol {
    
    @Published var title = ""
    @Published var subtitle = ""
    @Published var body = ""
    @Published var link = ""
    
    @Published var alert: AddPostAlert?
    @Published var isLoading: Bool = false
    
    @Injected(\.postInteractor) var postInteractor
    
    private weak var coordinator: AddPostCoordinatorDelegate?
    
    init(coordinator: AddPostCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator?.close()
    }
    
    func submitPost() {
        isLoading = true
        Task {
            do {
                try await postInteractor.submitPost()
            } catch {
                await MainActor.run {
                    alert = AddPostAlert.missingBody
                }
                print(error)
            }
            await MainActor.run {
                isLoading = false
                close()
            }
            
        }
    }
    
}
