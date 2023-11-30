//
//  RootCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import Factory
import Foundation

final class RootCoordinator: Coordinator {
    
    @Injected(\.accountService) private var accountService
    @Published var loginStatus: LoginStatus = .loggedOut
    
    @Published var isShowingOnboardingFlow = false
    
    let mainTabViewModel = MainTabViewModel()
    
    func onboardingCoordinator() -> OnboardingCoordinator {
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

extension RootCoordinator: OnboardingCoordinatorParent {
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
