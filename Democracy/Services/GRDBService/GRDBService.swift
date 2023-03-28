//
//  GRDBService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/26/23.
//

import Foundation
import GRDB

protocol GRDBServiceProtocol {
    var database: DatabaseQueue? { get }
}

class GRDBService: GRDBServiceProtocol {
    
    lazy var database: DatabaseQueue? = {
        do {
            // Create the "Application Support/MyDatabase" directory if needed
            let appSupportURL = URL.applicationSupportDirectory
            let directoryURL = appSupportURL.appendingPathComponent("MyDatabase", isDirectory: true)
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)

            // Open or create the database
            let databaseURL = directoryURL.appendingPathComponent("db.sqlite")
            let dbQueue = try DatabaseQueue(path: databaseURL.path)
            try migrator.migrate(dbQueue)
            return dbQueue
        } catch {
            print("\(error)")
            return nil
        }
    }()
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("firstMigration") { db in
            // Create a table
            // See <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/databaseschema>
            try db.create(table: "candidate") { t in
                
                t.column("id", .text).primaryKey()
                t.column("userName", .text).notNull()
                t.column("firstName", .text)
                t.column("lastName", .text)
                t.column("imageName", .text)
                t.column("upVotes", .integer).notNull()
                t.column("downVotes", .integer).notNull()
                t.column("communityId", .text).notNull()
                t.column("isRepresentative", .boolean).notNull()
                t.column("summary", .text).notNull()
                t.column("externalLink", .text)
            }
        }
        
        
        // Migrations for future application versions will be inserted here:
        // migrator.registerMigration(...) { db in
        //     ...
        // }
        
        return migrator
    }
    
}
