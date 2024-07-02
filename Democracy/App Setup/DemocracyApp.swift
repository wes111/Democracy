//
//  DemocracyApp.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import SwiftData
import SwiftUI

@main
struct DemocracyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let dataProvider = DataProvider.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(dataProvider.sharedModelContainer)
        // TODO: This isn't needed if we don't access model objects from views.
    }
}
