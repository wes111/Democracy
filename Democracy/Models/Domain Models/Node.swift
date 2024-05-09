//
//  Node.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/24.
//

import Foundation

class Node<Value> {
    var value: Value
    var children: [Node]? // This needs to be optional for SwiftUI's `OutlineGroup`.
    weak var parent: Node?
    
    init(value: Value) {
        self.value = value
    }
    
    init(value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }
}

// MARK: - Computed Properties
extension Node {
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return children == nil
    }
}

// MARK: - Methods
extension Node {
    
    func addChild(_ child: Node) {
        if children == nil {
            children = []
        }
        children?.append(child)

        child.parent = self
    }
    
    func addChildren(_ newChildren: [Node]) {
        if children == nil {
            children = []
        }
        children?.append(contentsOf: newChildren)
        newChildren.forEach { $0.parent = self }
    }
    
    func depth() -> Int {
        var depth = 0
        var currentNode: Node? = self
        
        while let parent = currentNode?.parent {
            depth += 1
            currentNode = parent
        }
        
        return depth
    }
}

// MARK: - Extensions
extension Node: Equatable where Value: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}

extension Node: Hashable where Value: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}
