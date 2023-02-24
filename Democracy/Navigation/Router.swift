//
//  Router.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Foundation
import SwiftUI

protocol RouterProtocol: ObservableObject {
    //associatedtype Path: Hashable
    var navigationPath: NavigationPath { get }
    
    func push(_ path: any Hashable)
    func push(_ paths: [any Hashable])
    func pop()
    func pop(count: Int)
    func popToRoot()
}

final class Router: RouterProtocol {
    
    @Published var navigationPath = NavigationPath()
    
    init() {}
    
    func push(_ path: any Hashable) {
        navigationPath.append(path)
    }
    
    func push(_ paths: [any Hashable]) {
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
