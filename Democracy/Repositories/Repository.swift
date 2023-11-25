//
//  Repository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/25/23.
//

import AsyncAlgorithms
import Foundation

protocol Repository {
    associatedtype Object: Codable, Sendable
    var asyncChannel: AsyncChannel<Object?> { get }
    var currentValue: Object? { get async }
}
