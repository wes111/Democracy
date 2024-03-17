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
                summaryView(category: $viewModel.settings.government, setting: .governmentType)
                summaryView(category: $viewModel.settings.content, setting: .allowsAdultContent)
                summaryView(category: $viewModel.settings.visibility, setting: .visibility)
                summaryView(category: $viewModel.settings.poster, setting: .poster)
                summaryView(category: $viewModel.settings.commenter, setting: .commenter)
                summaryView(category: $viewModel.settings.postApproval, setting: .postApproval)
            }
            .padding(ViewConstants.smallInnerBorder)
        }
    }
    
    func summaryView<T: Selectable>(category: Binding<T>, setting: CommunitySetting) -> some View {
        SelectablePickerView(
            action: { viewModel.selectedSetting = setting },
            dismissAction: { viewModel.selectedSetting = nil },
            selection: category
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitySettingsView(viewModel: .preview)
    }
}
