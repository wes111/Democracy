//
//  Node.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/24.
//

import Foundation

@Observable
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
    
    init(value: Value, parent: Node?) {
        self.value = value
        self.parent = parent
    }
    
    var isLastChild: Bool {
        guard let parent = parent, let siblings = parent.children else {
            return false
        }
        return siblings.last === self
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
    
    var depth: Int {
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

@Observable
final class CommentNode: Node<Comment>, Identifiable {
    
    var id: String {
        value.id + (parent?.value.id ?? "")
    }
    
    var replies: [CommentNode]? {
        children as! [CommentNode]?
    }
    
    var parentComment: CommentNode? {
        parent as! CommentNode?
    }
    
    static func loadMoreNode(parent: CommentNode?) -> CommentNode {
        let comment = Comment(id: "end", parentId: "", postId: "", userId: "", creationDate: .now, content: "", upVoteCount: 0, downVoteCount: 0, responseCount: 0)
        return CommentNode(value: comment, parent: parent)
    }
    
    var isLoadMoreNode: Bool {
        id.hasPrefix("end")
    }
}
