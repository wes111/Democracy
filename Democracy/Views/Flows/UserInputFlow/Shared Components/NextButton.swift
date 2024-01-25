//
//  NextButton.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI

struct NextButton: View {
    @Binding var isShowingProgress: Bool
    var nextAction: () async -> Void
    var isDisabled: Bool
    
    var body: some View {
        AsyncButton(
            action: { await nextAction() },
            label: { Text("Next") },
            showProgressView: $isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .isDisabledWithAnimation(isDisabled: isDisabled)
    }
}

// MARK: - Preview
#Preview {
    NextButton(
        isShowingProgress: .constant(false),
        nextAction: {},
        isDisabled: false
    )
}
