//
//  ProgressModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/16/24.
//

import SwiftUI

struct ProgressModifier: ViewModifier {
    @Binding var isShowingProgress: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            CustomProgressView()
                .opacity(isShowingProgress ? 1.0 : 0.0)
        }
    }
}

// MARK: View Extension
extension View {
    func progressModifier(isShowingProgess: Binding<Bool>) -> some View {
        modifier(ProgressModifier(isShowingProgress: isShowingProgess))
    }
}
