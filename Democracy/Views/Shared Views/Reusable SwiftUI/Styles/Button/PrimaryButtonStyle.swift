//
//  PrimaryButtonStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import SwiftUI

struct ExtraSmallSecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.primaryText)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.vertical, ViewConstants.extraSmallInnerBorder)
            .padding(.horizontal, ViewConstants.smallInnerBorder)
            .overlay(
                Capsule()
                    .stroke(Color.tertiaryText, style: StrokeStyle(lineWidth: 1))
             )
            .contentShape(Capsule())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

struct SmallSecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding(ViewConstants.smallInnerBorder)
            .frame(width: 75)
            .overlay(
                Capsule()
                    .stroke(Color.tertiaryText, style: StrokeStyle(lineWidth: 1))
             )
            .contentShape(Capsule())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

struct SeconaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                Capsule()
                    .stroke(Color.tertiaryText, style: StrokeStyle(lineWidth: 1))
             )
            .contentShape(Capsule())
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

struct SmallImageButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(Color.otherRed)
            .frame(height: ViewConstants.smallButtonRadius)
            .overlay(
                configuration.label
                    .fontWeight(.bold)
                    .foregroundStyle(Color.primaryText)
            )
            .foregroundStyle(Color.primaryText)
            .fontWeight(.bold)
            .contentShape(Circle())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.otherRed, in: Capsule())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.secondaryText)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, ViewConstants.innerBorder)
            .padding(.vertical, ViewConstants.smallInnerBorder)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(Color.secondaryBackground)
            )
            .contentShape(Capsule())
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground
        
        VStack(spacing: 25) {
            Button {
                print()
            } label: {
                Text("Submit")
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Submit")
            }
            .buttonStyle(SeconaryButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Join")
            }
            .buttonStyle(SmallSecondaryButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Join")
            }
            .buttonStyle(ExtraSmallSecondaryButtonStyle())
            
            Button(action: {}) {
                Image(systemName: SystemImage.plus.rawValue)
            }
            .buttonStyle(SmallImageButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Load Replies")
            }
            .buttonStyle(TertiaryButtonStyle())
        }
    }
    .ignoresSafeArea()
}
