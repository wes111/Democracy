//
//  SuccessView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/7/24.
//

import SwiftUI

struct ButtonInfo {
    let title: String
    let action: @MainActor () -> Void
}

// Generic success view.
@MainActor
struct SuccessView: View {
    let primaryText: Text
    let secondaryText: Text
    let image: Image
    let primaryButtonInfo: ButtonInfo
    let secondaryButtonInfo: ButtonInfo?
    
    init(
        primaryText: Text,
        secondaryText: Text,
        image: Image,
        primaryButtonInfo: ButtonInfo,
        secondaryButtonInfo: ButtonInfo?
    ) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.image = image
        self.primaryButtonInfo = primaryButtonInfo
        self.secondaryButtonInfo = secondaryButtonInfo
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            topLogo
            centerContent
            bottomButtons
        }
        .padding(ViewConstants.screenPadding)
        .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
        
    }
    
    // MARK: - Subviews
    var topLogo: some View { // TODO: This could be more generic.
        VStack {
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                .foregroundStyle(Color.green)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var centerContent: some View {
        VStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
            Spacer()
            primaryText
                .font(.system(.title, weight: .semibold))
                .foregroundColor(.primaryText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            secondaryText
                .font(.system(.body, weight: .regular))
                .foregroundColor(.tertiaryText)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var bottomButtons: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            Spacer()
            primaryButton
            
            if let secondaryButtonInfo {
                secondaryButton(info: secondaryButtonInfo)
            }
        }
    }
    
    var primaryButton: some View {
        Button {
            primaryButtonInfo.action()
        } label: {
            Label {
                Text(primaryButtonInfo.title)
            } icon: {
                Image(systemName: "arrow.right")
            }
            .labelStyle(ReversedLabelStyle())
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    func secondaryButton(info: ButtonInfo) -> some View {
        Button {
            info.action()
        } label: {
            Text(info.title)
        }
        .buttonStyle(SeconaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    SuccessView(
        primaryText: Text("Welcome to Democracy,\n Hamlin111"),
        secondaryText: Text("Hello World!"),
        image: Image("BMW"),
        primaryButtonInfo: .init(title: "Next", action: {}),
        secondaryButtonInfo: .init(title: "Continue", action: {})
    )
}
