//
//  GRDBService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/26/23.
//

import Foundation
import GRDB

protocol GRDBServiceProtocol {
    
    func getDatabaseConnection() throws -> DatabaseQueue
}

class GRDBService: GRDBServiceProtocol {
    
    func getDatabaseConnection() throws -> DatabaseQueue {
        
        guard let database else {
            throw GRDBServiceError.unexpected
        }
        
        return database
    }
    
    private lazy var database: DatabaseQueue? = {
        do {
            // Create the "Application Support/MyDatabase" directory if needed
            let appSupportURL = URL.applicationSupportDirectory
            let directoryURL = appSupportURL.appendingPathComponent("MyDatabase", isDirectory: true)
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)

            // Open or create the database
            let databaseURL = directoryURL.appendingPathComponent("db.sqlite")
            let dbQueue = try! DatabaseQueue(path: databaseURL.path)
            try migrator.migrate(dbQueue)
            return dbQueue
        } catch {
            print("\(error)")
            return nil
        }
    }()
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("firstMigration") { database in
            // Create a table
            // See <https://swiftpackageindex.com/groue/grdb.swift/documentation/grdb/databaseschema>
            try database.create(table: "candidate") { table in
                
                table.column("id", .text).primaryKey()
                table.column("userName", .text).notNull()
                table.column("firstName", .text)
                table.column("lastName", .text)
                table.column("imageName", .text)
                table.column("upVotes", .integer).notNull()
                table.column("downVotes", .integer).notNull()
                table.column("communityId", .text).notNull()
                table.column("isRepresentative", .boolean).notNull()
                table.column("summary", .text).notNull()
                table.column("externalLink", .text)
            }
            
            try database.create(table: "user", body: { table in
                table.column("id", .text).primaryKey()
                table.column("userName", .text).notNull()
                table.column("firstName", .text)
                table.column("lastName", .text)
            })
            
            
        }
        
        
        // Migrations for future application versions will be inserted here:
        // migrator.registerMigration(...) { db in
        //     ...
        // }
        
        return migrator
    }
    
}

enum GRDBServiceError: Error {
    case unexpected
}

