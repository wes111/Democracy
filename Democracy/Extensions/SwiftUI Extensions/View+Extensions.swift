//
//  View+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/30/23.
//

import SwiftUI
import Combine

// https://stackoverflow.com/questions/65784294/how-to-detect-if-keyboard-is-present-in-swiftui
// Publishes a bool value indicating whether the keyboard is visible.
extension View {
    
    @MainActor var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in false })
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

// TODO: ...
//#Preview {
//    View_Extensions()
//}
