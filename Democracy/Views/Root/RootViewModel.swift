//
//  RootViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Factory
import Foundation

final class RootViewModel: ObservableObject {
    @Injected(\.accountService) private var accountService
    @Published var loginStatus: LoginStatus = .loggedOut
    
    let mainTabViewModel = MainTabViewModel()
    
    lazy var rootCoordinator: RootCoordinator = {
        .init()
    }()
    
    init() {
        Task {
            await setupBindings()
        }
    }
}

// MARK: Private Methods
private extension RootViewModel {
    func setupBindings() async {
        for await session in accountService.sessionStream {
            loginStatus = session == nil ? .loggedOut : .loggedIn
        }
    }
}
