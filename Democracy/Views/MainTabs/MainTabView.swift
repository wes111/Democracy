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

struct MainTabView: View {
    
    @State private var selectedTab: MainTab = .updates
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VotingTabCoordinator()
                .tabItem {
                    Label("Voting", systemImage: "checklist")
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
            
            CommunitiesTabCoordinator()
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
    }
    
}
