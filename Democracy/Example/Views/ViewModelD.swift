//
//  ViewModelD.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol DCoordinatorDelegate {
    func DToB()
    func DToC()
    func DToE()
}

protocol ViewModelDProtocol: ObservableObject {
    func DToB()
    func DToC()
    func DToE()
}

final class ViewModelD: ViewModelDProtocol {

    var coordinator: DCoordinatorDelegate
    
    init(coordinator: DCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func DToB() {
        coordinator.DToB()
    }
    
    func DToE() {
        coordinator.DToE()
    }
    
    func DToC() {
        coordinator.DToC()
    }
    
}
