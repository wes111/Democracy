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
    var onboardingAlert: OnboardingAlert?
    
    var coordinator: SubmitPostCoordinatorDelegate?
    
    typealias Field = PostTitleValidator
    
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    
    init(coordinator: SubmitPostCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    @Published var alert: AddPostAlert?
    @Published var isLoading: Bool = false
    
    @Injected(\.postInteractor) var postInteractor
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
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
