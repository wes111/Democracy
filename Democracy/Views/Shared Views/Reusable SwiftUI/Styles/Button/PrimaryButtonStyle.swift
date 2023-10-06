//
//  PrimaryButtonStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import SwiftUI

struct SeconaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.tertiaryText, style: StrokeStyle(lineWidth: 1))
             )
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

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
        
        VStack {
            Button {
                print()
            } label: {
                Text("Submit")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
            
            Button {
                print()
            } label: {
                Text("Submit")
            }
            .buttonStyle(SeconaryButtonStyle())
            .padding()
        }

        
    }
    .ignoresSafeArea()
}
