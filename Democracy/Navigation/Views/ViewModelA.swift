//
//  ViewModelA.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Combine
import SwiftUI

protocol ACoordinatorDelegate: AnyObject {
    func goToB()
    func goToE()
    func getPathsPublisher() -> AnyPublisher<[MainPath], Never>
    
    func createViewFromPath(_ path: MainPath) -> any View
}

protocol ViewModelAProtocol: ObservableObject {
    var paths: [MainPath] { get set }
    func goToB()
    func goToE()
}

final class ViewModelA: ViewModelAProtocol {
    
    @Published var paths: [MainPath] = []
    
    weak var coordinator: ACoordinatorDelegate? {
        didSet {
            coordinator?
                .getPathsPublisher()
                .assign(to: &$paths)
        }
    }
    
    init() {}
    
    func goToB() {
        coordinator?.goToB()
    }
    
    func goToE() {
        coordinator?.goToB()
    }
    
}
