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

@MainActor
final class MainTabViewModel: ObservableObject {
    @Published var selectedTab: MainTab = .updates
    
    let communitiesTabCoordinator = CommunitiesTabCoordinator()
    let votingTabCoordinator = VotingTabCoordinatorViewModel()
    let eventsTabCoordinator = EventsTabCoordinatorViewModel()
    let updatesTabCoordinator = UpdatesTabCoordinatorViewModel()
    let historyTabCoordinator = HistoryTabCoordinatorViewModel()
}

struct MainTabView: View {
    
    @StateObject private var viewModel: MainTabViewModel
    
    init(viewModel: MainTabViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.tertiaryBackground)
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(.primaryText)
        ]
        navigationBarAppearance.backgroundColor = UIColor(.primaryBackground)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().clipsToBounds = true
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = UIColor(.primaryBackground)
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
    }
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            VotingTabCoordinator(viewModel: viewModel.votingTabCoordinator)
                .tabItem {
                    Label("Voting", systemImage: "checklist")
                        .foregroundColor(.primaryText)
                }
                .tag(MainTab.voting)
            
            EventsTabCoordinator(viewModel: viewModel.eventsTabCoordinator)
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(MainTab.events)
            
            UpdatesTabCoordinator(viewModel: viewModel.updatesTabCoordinator)
                .tabItem {
                    Label("Updates", systemImage: "newspaper.fill")
                }
                .tag(MainTab.updates)
            
            CommunitiesTabCoordinatorView(coordinator: viewModel.communitiesTabCoordinator)
                .tabItem {
                    Label("Communities", systemImage: "person.3.fill")
                }
                .tag(MainTab.communities)
            
            HistoryTabCoordinator(viewModel: viewModel.historyTabCoordinator)
                .tabItem {
                    Label("History", systemImage: "books.vertical.fill")
                }
                .tag(MainTab.history)
        }
        .navigationBarBackButtonHidden()
        .accentColor(.secondaryText)
    }
    
}

// MARK: - Preview
#Preview {
    let viewModel = MainTabViewModel()
    return MainTabView(viewModel: viewModel)
}
