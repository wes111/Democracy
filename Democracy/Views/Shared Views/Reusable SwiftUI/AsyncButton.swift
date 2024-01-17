//
//  AsyncButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import SwiftUI

// TODO: Read this article for interesting info about common bug with loading indicators!
// https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/

struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isDisabled: Bool = false
    @Binding var showProgressView: Bool

    var body: some View {
        Button(
            action: {
                isDisabled = true
                
                Task {
                    var progressViewTask: Task<Void, Error>?
                    
                    progressViewTask = Task {
                        try await Task.sleep(nanoseconds: 150_000_000)
                        showProgressView = true
                    }
                    
                    await action()
                    progressViewTask?.cancel()
                    Task { // Fixes bug where progressView is not dismissed.
                        try await Task.sleep(nanoseconds: 150_000)
                        withAnimation {
                            isDisabled = false
                            showProgressView = false
                        }
                    }
                }
            },
            label: {
                label()
            }
        )
        .isDisabledWithAnimation(isDisabled: isDisabled || showProgressView)
    }
}

// MARK: - Preview
#Preview {
    AsyncButton(
        action: { {}() },
        label: { Text("Hello") },
        showProgressView: .constant(true)
    )
}
