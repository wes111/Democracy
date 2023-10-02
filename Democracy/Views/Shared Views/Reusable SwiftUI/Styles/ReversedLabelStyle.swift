//
//  ReversedLabelStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/7/23.
//

import SwiftUI

struct ReversedLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

//MARK: - Preview
#Preview {
    Label("Label Title", systemImage: "chevron.right")
        .labelStyle(ReversedLabelStyle())
}
