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

struct CommunityViewPicker<ViewModel: CommunityViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    @State private var tabSelection: CommunityTab = .feed
    
    init(viewModel: ViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            
            Picker(selection: $tabSelection, label: Text("Picker")) {
                Text(CommunityTab.info.rawValue).tag(CommunityTab.info)
                Text(CommunityTab.feed.rawValue).tag(CommunityTab.feed)
                Text(CommunityTab.archive.rawValue).tag(CommunityTab.archive)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
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
        .navigationTitle(viewModel.community.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if tabSelection == .feed {
                    Button {
                        viewModel.showCreatePostView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityViewPicker(viewModel: CommunityViewModel.preview)
        }
        
    }
}
