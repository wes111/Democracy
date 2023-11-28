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
    
    init() {}
}

// MARK: Methods
extension RootViewModel {
    @MainActor func startSessionTask() async {
        let stream = await accountService.sessionStream
        do {
            for try await session in stream {
                loginStatus = session == nil ? .loggedOut : .loggedIn
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
