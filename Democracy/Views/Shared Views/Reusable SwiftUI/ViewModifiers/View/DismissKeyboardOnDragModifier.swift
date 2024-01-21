//
//  DismissKeyboardOnDragModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/18/24.
//

import SwiftUI

struct DismissKeyboardOnDragModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            })
    }
}

extension View {
    func dismissKeyboardOnDrag() -> some View {
        self.modifier(DismissKeyboardOnDragModifier())
    }
}
