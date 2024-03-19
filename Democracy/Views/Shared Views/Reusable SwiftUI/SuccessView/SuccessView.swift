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
struct SuccessView<ViewModel: SuccessViewModel>: View {
    
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            topLogo
            centerContent
            bottomButtons
        }
        .padding(ViewConstants.screenPadding)
        .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(trailingButtons: [.close(viewModel.closeAction)])
        
    }
    
    // MARK: - Subviews
    var topLogo: some View { // TODO: This could be more generic.
        VStack {
            viewModel.imageType.image
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
            Text(viewModel.primaryText)
                .font(.system(.title, weight: .semibold))
                .foregroundColor(.primaryText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            Text(viewModel.secondaryText)
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
            
            if let secondaryButtonInfo = viewModel.secondaryButtonInfo {
                secondaryButton(info: secondaryButtonInfo)
            }
        }
    }
    
    var primaryButton: some View {
        Button {
            viewModel.primaryButtonInfo.action()
        } label: {
            Label {
                Text(viewModel.primaryButtonInfo.title)
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
    SuccessView(viewModel: PostSuccessViewModel(closeAction: {}))
}
