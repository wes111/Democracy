//
//  CurrentScheme.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/2/24.
//

import Foundation
import SwiftData

// https://fatbobman.com/en/posts/practical-swiftdata-building-swiftui-applications-with-modern-approaches/
typealias CurrentScheme = SchemaV1

enum SchemaV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version {
        .init(1, 0, 0)
    }
    
    static var models: [any PersistentModel.Type] {
        [MembershipData.self]
    }
}

final class DataProvider: Sendable {
    static let shared = DataProvider()
    
    let sharedModelContainer: ModelContainer = {
        let schema = Schema(CurrentScheme.models)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    func dataHandlerCreator() -> @Sendable () async -> DataHandler {
        let container = sharedModelContainer
        return { DataHandler(modelContainer: container) }
    }
    
    init() {}
}
