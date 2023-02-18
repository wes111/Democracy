//
//  ViewModelE.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol ECoordinatorDelegate {
    func EToB()
    func EToC()
    func EToD()
}

protocol ViewModelEProtocol: ObservableObject {
    func EToB()
    func EToC()
    func EToD()
}

final class ViewModelE: ViewModelEProtocol {

    var coordinator: ECoordinatorDelegate
    
    init(coordinator: ECoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func EToB() {
        coordinator.EToB()
    }
    
    func EToC() {
        coordinator.EToC()
    }
    
    func EToD() {
        coordinator.EToD()
    }
    
    
}
