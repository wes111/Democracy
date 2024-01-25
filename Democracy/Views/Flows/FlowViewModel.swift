//
//  FlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor
protocol FlowCoordinatorDelegate: AnyObject {
    func close()
    func goBack()
}

@Observable class FlowViewModel<Coordinator: FlowCoordinatorDelegate> {
    var isShowingProgress: Bool = false
    var text: String = ""
    var alertModel: NewAlertModel?
    weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator?) {
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
