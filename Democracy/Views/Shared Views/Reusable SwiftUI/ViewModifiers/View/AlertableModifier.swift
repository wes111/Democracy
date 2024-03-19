//
//  AlertableModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/16/24.
//

import SwiftUI

struct AlertableModifier: ViewModifier {
    @Binding var alertModel: NewAlertModel?
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertModel) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.description),
                    dismissButton: .default(Text("Okay"))
                )
            }
    }
}

// MARK: - View Extension
extension View {
    func alertableModifier(alertModel: Binding<NewAlertModel?>) -> some View {
        modifier(AlertableModifier(alertModel: alertModel))
    }
}
