//
//  CoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/7/23.
//

import SwiftUI

struct CoordinatorView<Path: Hashable, RootView: View, PushedView: View>: View {
    
    @Bindable var router: Router
    private let mainScreen: RootView
    private let secondaryScreen: (_ path: Path) -> PushedView
    
    init(router: Router,
         @ViewBuilder mainScreen: () -> RootView,
         @ViewBuilder secondaryScreen: @escaping (_ path: Path) -> PushedView
    ) {
        self.router = router
        self.mainScreen = mainScreen()
        self.secondaryScreen = secondaryScreen
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            mainScreen
                .navigationDestination(for: Path.self) { path in
                    secondaryScreen(path)
                }
        }
    }
}

// TODO: Combine with above if this works...
struct ChildCoordinatorView<Path: Hashable, RootView: View, PushedView: View>: View {
    @Bindable var router: Router
    private let mainScreen: RootView
    private let secondaryScreen: (_ path: Path) -> PushedView
    
    init(router: Router,
         @ViewBuilder mainScreen: () -> RootView,
         @ViewBuilder secondaryScreen: @escaping (_ path: Path) -> PushedView
    ) {
        self.router = router
        self.mainScreen = mainScreen()
        self.secondaryScreen = secondaryScreen
    }
    
    // NOTE: There is no NavigationStack here. This is the primary difference between this view
    // and the CoordinatorView...
    var body: some View {
        mainScreen
            .navigationDestination(for: Path.self) { path in
                secondaryScreen(path)
            }
    }
}

// MARK: - Preview
#Preview {
    CoordinatorView(router: .init()) {
        Text("Hello")
    } secondaryScreen: { (_: CommunitiesTabPath) in
        Text("World")
    }
}
