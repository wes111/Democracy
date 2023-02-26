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
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
                .tag(MainTab.voting)
            
            EventsTabCoordinator()
                .tabItem {
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
                .tag(MainTab.events)
            
            UpdatesTabCoordinator()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                    Text("Notes")
                }
                .tag(MainTab.updates)
            
            CommunitiesTabCoordinator()
                .tabItem {
                    Label("Share", systemImage: "square.and.arrow.up")
                    Text("Share")
                }
                .tag(MainTab.communities)
            
            HistoryTabCoordinator()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                    Text("Settings")
                }
                .tag(MainTab.history)
        }
        .navigationBarBackButtonHidden()
    }
    
}
