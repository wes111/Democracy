//
//  PostSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import Foundation

final class PostSuccessViewModel: ObservableObject, Hashable {
    private weak var coordinator: SubmitPostCoordinator?
    
    init(coordinator: SubmitPostCoordinator?) {
        self.coordinator = coordinator
    }
}

// MARK: - Computed Properties
extension PostSuccessViewModel {
    
    var primaryButtonInfo: ButtonInfo {
        .init(title: "Finish", action: close)
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension PostSuccessViewModel {
    
    @MainActor func close() {
        coordinator?.close()
    }
}
