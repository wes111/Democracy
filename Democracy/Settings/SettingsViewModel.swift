//
//  ViewModelE.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol SettingsCoordinatorDelegate {

}

protocol SettingsViewModelProtocol: ObservableObject {

}

final class SettingsViewModel: SettingsViewModelProtocol {

    var coordinator: SettingsCoordinatorDelegate
    
    init(coordinator: SettingsCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    

    
    
}
