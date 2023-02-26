//
//  ViewModelC.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol CCoordinatorDelegate {
    func CToB()
    func CToD()
    func CToE()
}

protocol ViewModelCProtocol: ObservableObject {
    func CToB()
    func CToD()
    func CToE()
}

final class ViewModelC: ViewModelCProtocol {
    
    var coordinator: CCoordinatorDelegate
    
    init(coordinator: CCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func CToB() {
        coordinator.CToB()
    }
    
    func CToE() {
        coordinator.CToE()
    }
    
    func CToD() {
        coordinator.CToD()
    }
    
}
