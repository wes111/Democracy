//
//  PostSecondaryLinksViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import Foundation

final class PostSecondaryLinksViewModel: UserInputViewModel {
    
    
    @Published var isShowingProgress: Bool = false
    @Published var alertModel: NewAlertModel?
    
    let title = "Add More Links"
    let subtitle = "Add additional links to your post."
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var skipAction: (() -> Void)? = {
        {} // TODO: ...
    }()
}

// MARK: - Computed Properties
extension PostSecondaryLinksViewModel {
    var canSubmit: Bool {
        true // TODO: ...
    }
}

// MARK: - Methods
extension PostSecondaryLinksViewModel {
    func submit() async {
//        guard canSubmit else {
//            return alertModel = NewAlertModel.genericAlert
//        }
//        
//        submitPostInput.category = selectedCategory
//        coordinator?.didSubmitCategory(input: submitPostInput)
    }
    
    func close() {
        coordinator?.close()
    }
}
