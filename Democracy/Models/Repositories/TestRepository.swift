//
//  TestRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/31/24.
//

import Foundation

// https://stackoverflow.com/questions/75855208/thread-safe-combine-publisher-to-asyncstream
protocol Streamable: Actor {
    associatedtype Object: Sendable
    
    var continuations: [UUID: AsyncStream<Object>.Continuation] { get set }
    
    func values() -> AsyncStream<Object>
    func send(_ value: Object)
}

extension Streamable {
    
    func values() -> AsyncStream<Object> {
        AsyncStream { continuation in
            let id = UUID()
            continuations[id] = continuation

            continuation.onTermination = { _ in
                Task { await self.cancel(id) }
            }
        }
    }

    func send(_ value: Object) {
        for continuation in continuations.values {
            continuation.yield(value)
        }
    }
}

private extension Streamable {
    func cancel(_ id: UUID) {
        continuations[id] = nil
    }
}
