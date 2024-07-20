//
//  CommunitySettingsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunitySettingsView: View {
    @Bindable var viewModel: CommunitySettingsViewModel
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews
private extension CommunitySettingsView {
    
    var primaryContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            settingsView
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
    var settingsView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                SelectablePickerView(selection: $viewModel.settings.government)
                SelectablePickerView(selection: $viewModel.settings.content)
                SelectablePickerView(selection: $viewModel.settings.visibility)
                SelectablePickerView(selection: $viewModel.settings.poster)
                SelectablePickerView(selection: $viewModel.settings.commenter)
                SelectablePickerView(selection: $viewModel.settings.postApproval)
            }
            .padding(ViewConstants.smallInnerBorder)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitySettingsView(viewModel: .preview)
    }
}
