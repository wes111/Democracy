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

struct CommunityView<ViewModel: CommunityViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    @State private var tabSelection: CommunityTab = .feed
    
    init(viewModel: ViewModel) {
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
            
            TabView(selection: $tabSelection) {
                CommunityInfoView().tabItem {
                    Text(CommunityTab.info.rawValue)
                }
                .tag(CommunityTab.info)
                
                CommunityHomeFeedView().tabItem {
                    Text(CommunityTab.feed.rawValue)
                }
                .tag(CommunityTab.feed)
                
                CommunityArchiveFeedView().tabItem {
                    Text(CommunityTab.archive.rawValue)
                }
                .tag(CommunityTab.archive)
            }
            .tabViewStyle(.page)
        }
        .navigationTitle(viewModel.community.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        let community = Community(name: "Test Community", foundedDate: Date())
        let coordinator = CommunityCoordinator(community)
        let viewModel = CommunityViewModel(coordinator: coordinator, community: community)
        CommunityView(viewModel: viewModel)
    }
}
