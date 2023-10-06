//
//  CreateFieldViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/5/23.
//

import Foundation

final class CreateFieldViewModel<T: Validator>: ObservableObject, Hashable {
    
    @Published var text: String = ""
    @Published var textErrors: [T] = []
    
    let field: CreateField
    let submitAction: () -> Void
    
    init(submitAction: @escaping () -> Void) {
        self.field = T.field
        self.submitAction = submitAction
        
        setupBindings()
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
        T.maxCharacterCount
    }
    
    func setupBindings() {
        
        $text
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { text in
                guard !text.isEmpty else { return [] }
                return UserNameValidation.getFieldValidationErrors(fieldString: text)
            }
            .assign(to: &$textErrors)
    }
}
