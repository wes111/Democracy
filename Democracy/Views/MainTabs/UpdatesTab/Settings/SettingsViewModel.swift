//
//  ViewModelE.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol SettingsCoordinatorDelegate: AnyObject {

}

protocol SettingsViewModelProtocol: ObservableObject {

}

final class SettingsViewModel: SettingsViewModelProtocol {

    // private weak var coordinator: SettingsCoordinatorDelegate?
    
    init() {
        // self.coordinator = coordinator
    }
}
