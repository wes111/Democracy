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
            return dbQueue
        } catch {
            print("\(error)")
            return nil
        }
    }()
    
}
