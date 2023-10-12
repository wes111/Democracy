//
//  CreateFieldViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/5/23.
//

import Foundation

final class CreateFieldViewModel<Field: UserInputField>: ObservableObject, Hashable {
    
    @Published var text: String = ""
    @Published var textErrors: [Field.InputError] = []
    
    let field: Field = .init()
    let submitAction: () -> Void
    
    init(submitAction: @escaping () -> Void) {
        self.submitAction = submitAction
        
        setupBindings()
    }
    
    deinit {
        print()
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
    
    func setupBindings() {
        
        $text
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
}
