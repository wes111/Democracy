//
//  DataHandler.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/12/24.
//

import Foundation
import SwiftData

protocol DataHandler: ModelActor {
    associatedtype DataModel: PersistableData
    typealias DomainModel = DataModel.DomainModel
    
    func updateItem(model: DomainModel) throws
}

extension DataHandler {
    
    // TODO: Generics seem to cause an error with the Predicate...
    // https://www.reddit.com/r/SwiftUI/comments/17eqgbz/use_generic_keypath_with_swiftdata_query/
//    func fetchDataModel(for model: DomainModel) throws -> DataModel? {
//        let id = model.id
//        let fetchDescriptor = FetchDescriptor<DataModel>(predicate: #Predicate { $0.remoteId == id })
//        return try modelContext.fetch(fetchDescriptor).first
//    }
    
    func fetchIdentifier(id: String) throws -> PersistentIdentifier? {
        let id = id
        let fetchDescriptor = FetchDescriptor<DataModel>(predicate: #Predicate { $0.remoteId == id })
        return try modelContext.fetch(fetchDescriptor).first?.persistentModelID
    }
    
    // Fetch all instances of DataModel, with no filtering or sorting applied.
    func fetchAll() throws -> [DataModel] {
        let fetchDescriptor = FetchDescriptor<DataModel>()
        return try modelContext.fetch(fetchDescriptor)
    }
    
    func updateItem(model: DomainModel) throws {
        // TODO: ...
//        guard let dataModel: DataModel = try fetchDataModel(for: model) else {
//            return
//        }
//        dataModel.update(model)
//        try modelContext.save()
    }
    
    func deleteAll() throws {
        try modelContext.delete(model: DataModel.self)
    }
}
