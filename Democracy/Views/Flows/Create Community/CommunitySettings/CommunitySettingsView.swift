//
//  CommunitySettingsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CommunitySettingsView: View {
    @Bindable var viewModel: CommunitySettingsViewModel
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            primaryContent
        }
        .sheet(item: $viewModel.selectedSetting) { setting in
            switch setting {
            case .allowsAdultContent:
                selectableSheet(category: $viewModel.settings.content)
                
            case .governmentType:
                selectableSheet(category: $viewModel.settings.government)
                
            case .visibility:
                selectableSheet(category: $viewModel.settings.visibility)
                
            case .poster:
                selectableSheet(category: $viewModel.settings.poster)
                
            case .commenter:
                selectableSheet(category: $viewModel.settings.commenter)
                
            case .postApproval:
                selectableSheet(category: $viewModel.settings.postApproval)
            }
        }
        .brightness(viewModel.selectedSetting == nil ? 0.0 : ViewConstants.dimmingBrightness)
        .animation(.easeInOut, value: viewModel.selectedSetting)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Subviews
private extension CommunitySettingsView {
    
    var primaryContent: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                summaryView(category: viewModel.settings.government, setting: .governmentType)
                summaryView(category: viewModel.settings.content, setting: .allowsAdultContent)
                summaryView(category: viewModel.settings.visibility, setting: .visibility)
                summaryView(category: viewModel.settings.poster, setting: .poster)
                summaryView(category: viewModel.settings.commenter, setting: .commenter)
                summaryView(category: viewModel.settings.postApproval, setting: .postApproval)
            }
            .padding(ViewConstants.smallInnerBorder)
        }
    }
    
    func summaryView<Category: Selectable>(category: Category?, setting: CommunitySetting) -> some View {
        SelectableSummaryView(
            action: { viewModel.selectedSetting = setting },
            title: Category.metaTitle,
            currentSelection: category?.title ?? ""
        )
    }
    
    func selectableSheet<Category: Selectable>(category: Binding<Category>) -> some View {
        SelectableView(selectedCategory: category)
            .presentationDetents([
                .fraction(detentsFraction(categoryType: Category.self))
            ])
            .presentationDragIndicator(.visible)
    }
}

// MARK: - Helper Methods
private extension CommunitySettingsView {
    
    func detentsFraction<Category: Selectable>(categoryType: Category.Type) -> Double {
        switch Category.allCases.count {
        case 2:
            0.5
        case 3:
            0.6
        case 4:
            0.7
        case 5:
            0.8
        default:
            0.4
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitySettingsView(viewModel: .preview)
    }
}
