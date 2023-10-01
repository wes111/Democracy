//
//  CoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/7/23.
//

import SwiftUI

struct CoordinatorView<Path: Hashable, RootView: View, NavigationViewBuilder: View>: View {
    
    @Binding var router: Router
    private let mainScreen: RootView
    private let secondaryScreen: (_ path: Path) -> NavigationViewBuilder
    
    init(router: Binding<Router>,
         @ViewBuilder mainScreen: () -> RootView,
         @ViewBuilder secondaryScreen: @escaping (_ path: Path) -> NavigationViewBuilder
    ) {
        self._router = router
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

//MARK: - Preview
#Preview {
    CoordinatorView(router: .constant(Router())) {
        Text("Hello")
    } secondaryScreen: { (path: CommunitiesTabPath) in
        Text("World")
    }
}
