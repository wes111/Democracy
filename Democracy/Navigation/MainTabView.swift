//
//  MainTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/19/23.
//

import SwiftUI

enum MainTab {
    case one, two, three, four, five
}

struct MainTabView: View {
    
    @State private var selectedTab: MainTab = .three
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainCoordinator()
                .tabItem {
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
                .tag(MainTab.one)
            
            MainCoordinator()
                .tabItem {
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
                .tag(MainTab.two)
            
            MainCoordinator()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                    Text("Notes")
                }
                .tag(MainTab.three)
            
            MainCoordinator()
                .tabItem {
                    Label("Share", systemImage: "square.and.arrow.up")
                    Text("Share")
                }
                .tag(MainTab.four)
            
            SettingsCoordinator()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                    Text("Settings")
                }
                .tag(MainTab.five)
        }
        .navigationBarBackButtonHidden()
    }
    
}
