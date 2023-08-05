//
//  MainTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/19/23.
//

import SwiftUI

enum MainTab {
    case voting, events, updates, communities, history
}

class MainTabViewModel: ObservableObject {
    @Published var selectedTab: MainTab = .updates
    
    let communitiesViewModel = CommunitiesTabCoordinatorViewModel()
    let votingViewModel = VotingTabCoordinatorViewModel()
}

struct MainTabView: View {
    
    @StateObject private var viewModel: MainTabViewModel
    
    init(viewModel: MainTabViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.tertiaryBackground)
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(.primaryText)
        ]
        navigationBarAppearance.backgroundColor = UIColor(.primaryBackground)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = UIColor(.primaryBackground)
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
    }
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            VotingTabCoordinator(viewModel: viewModel.votingViewModel)
                .tabItem {
                    Label("Voting", systemImage: "checklist")
                        .foregroundColor(.primaryText)
                }
                .tag(MainTab.voting)
            
            EventsTabCoordinator()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(MainTab.events)
            
            UpdatesTabCoordinator()
                .tabItem {
                    Label("Updates", systemImage: "newspaper.fill")
                }
                .tag(MainTab.updates)
            
            CommunitiesTabCoordinator(viewModel: viewModel.communitiesViewModel)
                .tabItem {
                    Label("Communities", systemImage: "person.3.fill")
                }
                .tag(MainTab.communities)
            
            HistoryTabCoordinator()
                .tabItem {
                    Label("History", systemImage: "books.vertical.fill")
                }
                .tag(MainTab.history)
        }
        .navigationBarBackButtonHidden()
        .accentColor(.secondaryText)
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainTabViewModel()
        MainTabView(viewModel: viewModel)
    }
}
