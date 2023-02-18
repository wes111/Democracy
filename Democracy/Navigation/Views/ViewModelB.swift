//
//  ViewModelB.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol BCoordinatorDelegate {
    func BToC()
    func BToD()
    func BToE()
}

protocol ViewModelBProtocol: ObservableObject {
    func BToC()
    func BToD()
    func BToE()
}

final class ViewModelB: ViewModelBProtocol {

    var coordinator: BCoordinatorDelegate
    
    init(coordinator: BCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func BToE() {
        coordinator.BToE()
    }
    
    func BToC() {
        coordinator.BToC()
    }
    
    func BToD() {
        coordinator.BToD()
    }
    
}
