//
//  CreateFieldViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/5/23.
//

import Foundation

enum OnboardingTopButton: CaseIterable {
    case back
    case close
}

protocol CreateFieldCoordinatorDelegate: AnyObject {
    func goBack()
    func close()
}

final class CreateFieldViewModel<T: OnboardingCreatable>: ObservableObject, Hashable {
    
    @Published var text: String = ""
    @Published var textErrors: [T.Field.InputError] = []
    
    private let creatable: T = .init()
    let submitAction: () -> Void
    private weak var coordinator: CreateFieldCoordinatorDelegate?
    
    init(submitAction: @escaping () -> Void, coordinator: CreateFieldCoordinatorDelegate?) {
        self.submitAction = submitAction
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    deinit {
        print()
    }
    
    var field: T.Field {
        creatable.field
    }
    
    var topButtons: [OnboardingTopButton : () -> Void] {
        var dictionary: [OnboardingTopButton : () -> Void] = [:]
        for button in creatable.topButtons {
            switch button {
            case .back:
                dictionary[.back] = goBack
            case .close:
                dictionary[.close] = close
            }
        }
        return dictionary
    }
    
    var title: String {
        field.title
    }
    
    var subtitle: String {
        field.subtitle
    }
    
    var fieldTitle: String {
        field.fieldTitle
    }
    
    var maxCharacterCount: Int {
        field.maxCharacterCount
    }
    
    private func setupBindings() {
        
        $text
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.creatable.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
