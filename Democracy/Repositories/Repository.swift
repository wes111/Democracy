//
//  Repository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/25/23.
//

import Asynchrone
import Foundation

protocol Repository {
    associatedtype Object: Codable, Sendable
    var asyncStream: SharedAsyncSequence<AsyncStream<Object?>> { get async }
    var currentValue: Object? { get async }
}
