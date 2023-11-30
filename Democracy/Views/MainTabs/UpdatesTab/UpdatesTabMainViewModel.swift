//
//  UpdatesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Factory
import Foundation

protocol UpdatesTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

protocol UpdatesTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
    func logout() async
}

final class UpdatesTabMainViewModel: UpdatesTabMainViewModelProtocol {
    
    @Injected(\.accountService) private var accountService
    
    func logout() async {
        do {
            try await accountService.logout()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //private weak var coordinator: UpdatesTabMainCoordinatorDelegate?
    
    init() {
        //self.coordinator = coordinator
    }
    
    func tappedNav() {
        //coordinator?.tappedNav()
    }
}
