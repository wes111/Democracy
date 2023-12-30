//
//  CustomProgressView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.secondaryText)
    }
}

// MARK: - Preview
#Preview {
    CustomProgressView()
}
