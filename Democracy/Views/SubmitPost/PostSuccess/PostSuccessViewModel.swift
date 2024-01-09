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
    
    lazy var primaryButtonInfo: ButtonInfo = {
        .init(title: "Finish", action: close)
    }()
    
    func close() {
        coordinator?.close()
    }
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}
