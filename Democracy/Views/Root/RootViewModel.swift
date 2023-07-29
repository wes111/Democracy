//
//  RootViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

class RootViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    let mainTabViewModel = MainTabViewModel()
    let authenticationCoordinatorViewModel: AuthenticationCoordinatorViewModel
    
    init() {
        authenticationCoordinatorViewModel = AuthenticationCoordinatorViewModel(mainTabViewModel: mainTabViewModel)
        temp_authPublisher.assign(to: &$isAuthenticated)
    }
}
