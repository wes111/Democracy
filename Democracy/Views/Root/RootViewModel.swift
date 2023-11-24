//
//  RootViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Factory
import Foundation

class RootViewModel: ObservableObject {
    @Published var loginStatus: LoginStatus = .loggedOut
    
    let mainTabViewModel = MainTabViewModel()
    
    lazy var rootCoordinator: RootCoordinator = {
        .init()
    }()
    
    init() {}
}

//MARK: Private Methods
private extension RootViewModel {
    func setupBindings() {
//        accountService.loginPublisher
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$loginStatus)
    }
}
