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
                SelectableSheetPickerView(selection: $viewModel.settings.government)
                SelectableSheetPickerView(selection: $viewModel.settings.content)
                SelectableSheetPickerView(selection: $viewModel.settings.visibility)
                SelectableSheetPickerView(selection: $viewModel.settings.poster)
                SelectableSheetPickerView(selection: $viewModel.settings.commenter)
                SelectableSheetPickerView(selection: $viewModel.settings.postApproval)
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
