//
//  Router.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Foundation
import SwiftUI

@MainActor
protocol RouterProtocol {
    var navigationPath: NavigationPath { get }
    
    func push<Path: Hashable>(_ path: Path)
    func push<Path: Hashable>(_ paths: [Path])
    func pop()
    func pop(count: Int)
    func popToRoot()
}

@MainActor @Observable
final class Router: RouterProtocol {
    
    var navigationPath = NavigationPath()
    
    init() {}
    
    func push<Path: Hashable>(_ path: Path) {
        navigationPath.append(path)
    }
    
    func push<Path: Hashable>(_ paths: [Path]) {
        paths.forEach { navigationPath.append($0) }
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func pop(count: Int) {
        for _ in 0..<count {
            navigationPath.removeLast()
        }
    }
    
    func popToRoot() {
        for _ in 0 ..< navigationPath.count {
            navigationPath.removeLast()
        }
    }
    
}
