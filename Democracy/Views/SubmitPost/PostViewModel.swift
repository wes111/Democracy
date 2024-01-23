//
//  SubmitPostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/22/24.
//

import Foundation

@Observable class PostViewModel {
    var isShowingProgress: Bool = false
    var text: String = ""
    var alertModel: NewAlertModel?
    weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(coordinator: SubmitPostCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    @MainActor
    func goBack() {
        coordinator?.goBack()
    }
}
