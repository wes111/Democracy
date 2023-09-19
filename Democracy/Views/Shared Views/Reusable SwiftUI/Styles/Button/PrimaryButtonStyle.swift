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
            .foregroundStyle(Color.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.otherRed, in: RoundedRectangle(cornerRadius: 10))
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

//MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground
        
        Button {
            print()
        } label: {
            Text("Submit")
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding()
    }
    .ignoresSafeArea()
}
