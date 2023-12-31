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
                    .map { _ in false }
            )
            .eraseToAnyPublisher()
    }
}

extension View {
    
    // See 'AsyncButton' for similar functionality.
    @MainActor
    func performAsnycTask(action: @escaping () async -> Void, isShowingProgress: Binding<Bool>) {
        Task {
            var progressViewTask: Task<Void, Error>?
            
            progressViewTask = Task {
                try await Task.sleep(nanoseconds: 150_000_000)
                withAnimation {
                    isShowingProgress.wrappedValue = true
                }
                
            }
            
            await action()
            progressViewTask?.cancel()
            withAnimation {
                isShowingProgress.wrappedValue = false
            }
        }
    }
}

extension View {
    func titledElement(title: String) -> some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            Text(title)
                .font(.system(.body, weight: .light))
                .foregroundColor(.primaryText)
                .fixedSize(horizontal: false, vertical: true)
            self
        }
    }
}
