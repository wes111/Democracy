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
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(.otherRed)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.init(.primaryText)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.init(.primaryText)], for: .selected)
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(!viewModel.isShowingNavigationBar)
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
            
            if tabSelection == .archive {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    
                    Menu {
                        Button("Category") {
                            viewModel.updateCommunityArchiveType(.category)
                        }
                        Button("Time") {
                            viewModel.updateCommunityArchiveType(.time)
                        }
                    } label: {
                        VStack(alignment: .center) {
                            Text("\(viewModel.selectedCommunityArchiveType)")
                                .font(.caption)
                        }
                        .frame(width: 85)
                        .padding(.vertical, 5)
                        .background( RoundedRectangle(cornerRadius: 10.0).fill(Color.secondaryBackground))
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(viewModel.community.name)
                        .font(.headline)
                        .foregroundColor(.tertiaryText)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.tertiaryText)
                }
            }
        }
        .background(
            Color.primaryBackground
        )

    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityViewPicker(viewModel: CommunityViewModel.preview)
                .accentColor(.secondaryText)
        }
        
    }
}
