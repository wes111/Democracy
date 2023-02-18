//
//  Router.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Foundation

protocol RouterProtocol: ObservableObject {
    associatedtype Path: Hashable
    var paths: [Path] { get }
    
    func push(_ path: Path)
    func push(_ paths: [Path])
    func pop()
    func pop(to path: Path)
    func popToRoot()
}

final class Router<T: Hashable>: RouterProtocol {
    
    @Published var paths: [T] = []
    
    init() {}
    
    func push(_ path: T) {
        paths.append(path)
    }
    
    func push(_ paths: [T]) {
        self.paths += paths
    }
    
    func pop() {
        paths.removeLast()
    }
    
    func pop(to path: T) {
        guard let popIndex = paths.firstIndex(where: { $0 == path }) else {
            return debugPrint("")
        }
        let popCount = paths.count - 1 - popIndex
        paths.removeLast(popCount)
    }
    
    func popToRoot() {
        paths = []
    }
    
}
