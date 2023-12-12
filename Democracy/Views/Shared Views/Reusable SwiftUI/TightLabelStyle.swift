//
//  TightLabelStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/3/23.
//

import SwiftUI

struct TightLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 2) {
            configuration.icon
            configuration.title
        }
    }
}

// MARK: - Preview
#Preview {
    Label("11", systemImage: "arrow.down")
        .labelStyle(TightLabelStyle())
}
