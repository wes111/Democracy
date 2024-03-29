//
//  RootCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import Factory
import Foundation

@MainActor @Observable
final class RootCoordinator {
    
    @ObservationIgnored @Injected(\.accountService) private var accountService
    var loginStatus: LoginStatus = .loggedOut
    var isShowingOnboardingFlow = false
    
    let mainTabViewModel = MainTabViewModel()
    
    func createAccountCoordinator() -> CreateAccountCoordinator {
        .init(parentCoordinator: self)
    }
    
}

// MARK: - Child ViewModels
extension RootCoordinator {
    
    func loginViewModel() -> LoginViewModel {
        .init(coordinator: self)
    }
    
}

extension RootCoordinator: LoginCoordinatorDelegate {
    func goToCreateAccount() {
        isShowingOnboardingFlow = true
    }
}

extension RootCoordinator: CreateAccountCoordinatorParent {
    func dismiss() {
        isShowingOnboardingFlow = false
    }
}

// MARK: Methods
extension RootCoordinator {
    @MainActor func startSessionTask() async {
        loginStatus = await accountService.currentSession == nil ? .loggedOut : .loggedIn
        do {
            for try await session in await accountService.sessionStream {
                loginStatus = session == nil ? .loggedOut : .loggedIn
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
