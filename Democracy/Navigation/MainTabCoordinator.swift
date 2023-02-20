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

struct MainTabCoordinator: View, Coordinator {
    
    @StateObject private var router = Router<MainPath>()
    let id = UUID()
    let parentCoordinator: Coordinator? = nil
    var childCoordinators: [UUID : Coordinator] = [:]
    
    func start() {
        print("start coordinator")
    }
    
    var body: some View {
        TabView {
            
            MainCoordinator(parentCoordinator: self)
                .tabItem {
                    Label("Editor", systemImage: "pencil.circle")
                    Text("Editor")
                }
            
            MainCoordinator(parentCoordinator: self)
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                    Text("Notes")
                }
            
            MainCoordinator(parentCoordinator: self)
                .tabItem {
                    Label("Share", systemImage: "square.and.arrow.up")
                    Text("Share")
                }
            
            MainCoordinator(parentCoordinator: self)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                    Text("Settings")
                }
        }
    }
    
}
