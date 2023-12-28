//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

protocol SubmitPostCoordinatorDelegate: AnyObject {
    func close()
    func goBack()
}

final class PostTitleViewModel: InputViewModel {
    typealias Field = PostTitleValidator
    
    @Injected(\.postInteractor) var postInteractor
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
    @Published var isLoading: Bool = false
    
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(coordinator: SubmitPostCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
}

// MARK: - Methods
extension PostTitleViewModel {
    
    @MainActor
    func submit() async {
        
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
