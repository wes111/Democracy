//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

enum CommunityTab: String {
    case feed = "Feed"
    case info = "Info"
    case archive = "Archive"
}

struct CommunityViewPicker: View {
    
    @StateObject private var viewModel: CommunityViewModel
    @State private var tabSelection: CommunityTab = .feed
    
    init(viewModel: CommunityViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(.otherRed)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(.primaryText)],
            for: .normal
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(.primaryText)],
            for: .selected
        )
        UISegmentedControl.appearance().backgroundColor = UIColor.init(.secondaryBackground)
    }
    
    var body: some View {
        VStack {
            if viewModel.isShowingNavigationBar {
                Picker(selection: $tabSelection, label: Text("Picker")) {
                    Text(CommunityTab.info.rawValue).tag(CommunityTab.info)
                    Text(CommunityTab.feed.rawValue).tag(CommunityTab.feed)
                    Text(CommunityTab.archive.rawValue).tag(CommunityTab.archive)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            
            TabView(selection: $tabSelection) {
                CommunityInfoView(viewModel: viewModel.getCommunityInfoViewModel())
                    .tabItem {
                        Text(CommunityTab.info.rawValue)
                    }
                    .tag(CommunityTab.info)
                
                CommunityHomeFeedView(viewModel: viewModel.getCommunityHomeFeedViewModel())
                    .tabItem {
                        Text(CommunityTab.feed.rawValue)
                    }
                    .tag(CommunityTab.feed)
                
                CommunityArchiveFeedView(viewModel: viewModel.getCommunityArchiveFeedViewModel())
                    .tabItem {
                        Text(CommunityTab.archive.rawValue)
                    }
                    .tag(CommunityTab.archive)
            }
            .tabViewStyle(.page)
        }
        .navigationBarHidden(!viewModel.isShowingNavigationBar)
        .toolbarNavigation(
            leadingButtons: viewModel.leadingButtons,
            trailingButtons: viewModel.trailingButtons,
            centerContent: .title(viewModel.community.name)
        )
        .toolbar {
            if tabSelection == .feed {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showCreatePostView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.tertiaryText)
                    }
                }
            }
        }
        .background(Color.primaryBackground)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityViewPicker(viewModel: CommunityViewModel.preview)
            .accentColor(.secondaryText)
    }
}
