//
//  PrimaryButtonStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.secondaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondaryBackground, in: RoundedRectangle(cornerRadius: 10))
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

//MARK: - Preview
#Preview {
    Button {
        print()
    } label: {
        Text("Submit")
    }
    .buttonStyle(PrimaryButtonStyle())
    .padding()
}
