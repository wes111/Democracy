//
//  MainTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/19/23.
//

import SwiftUI

enum MainTabPath: Hashable {
    case b
}

struct MainTabView: View {
    
    let mainTab = "Main"
    
    var body: some View {
        TabView(selection: Binding.constant(mainTab)) {
            MainCoordinator()
                .tabItem {
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
            
            MainCoordinator()
                .tabItem {
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
            
            MainCoordinator()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                    Text("Notes")
                }
                .tag(mainTab)
            
            MainCoordinator()
                .tabItem {
                    Label("Share", systemImage: "square.and.arrow.up")
                    Text("Share")
                }
            
            MainCoordinator()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                    Text("Settings")
                }
        }
        .navigationBarBackButtonHidden()
    }
    
}
