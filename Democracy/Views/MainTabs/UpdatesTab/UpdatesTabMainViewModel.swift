//
//  UpdatesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Factory
import Foundation

@MainActor
protocol UpdatesTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

protocol UpdatesTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
    func logout() async
    var isShowingProgress: Bool { get set }
}

final class UpdatesTabMainViewModel: UpdatesTabMainViewModelProtocol {
    
    @Injected(\.accountService) private var accountService
    @Published var isShowingProgress = false
    
    func logout() async {
        do {
            try await accountService.logout()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // private weak var coordinator: UpdatesTabMainCoordinatorDelegate?
    
    init() {
        // self.coordinator = coordinator
    }
    
    func tappedNav() {
        // coordinator?.tappedNav()
    }
}
