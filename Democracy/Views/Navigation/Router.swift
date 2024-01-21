//
//  Router.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Foundation
import SwiftUI

protocol RouterProtocol {
    var navigationPath: NavigationPath { get }
    
    func push<Path: Hashable>(_ path: Path)
    func push<Path: Hashable>(_ paths: [Path])
    func pop()
    func pop(count: Int)
    func popToRoot()
}

@Observable
final class Router: RouterProtocol {
    
    var navigationPath = NavigationPath()
    // Ideally we would make this an actor instead of class, but that does not work with published properties.
    // Using semaphore instead.
    @ObservationIgnored private let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    
    init() {}
    
    func push<Path: Hashable>(_ path: Path) {
        self.semaphore.wait()
        navigationPath.append(path)
        self.semaphore.signal()
    }
    
    func push<Path: Hashable>(_ paths: [Path]) {
        self.semaphore.wait()
        paths.forEach { navigationPath.append($0) }
        self.semaphore.signal()
    }
    
    func pop() {
        self.semaphore.wait()
        navigationPath.removeLast()
        self.semaphore.signal()
    }
    
    func pop(count: Int) {
        self.semaphore.wait()
        for _ in 0..<count {
            navigationPath.removeLast()
        }
        self.semaphore.signal()
    }
    
    func popToRoot() {
        self.semaphore.wait()
        for _ in 0 ..< navigationPath.count {
            navigationPath.removeLast()
        }
        self.semaphore.signal()
    }
    
}
