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

struct ReversedLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        Label("Label Title", systemImage: "chevron.right")
            .labelStyle(ReversedLabelStyle())
    }
}
