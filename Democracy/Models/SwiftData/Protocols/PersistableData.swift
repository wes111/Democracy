//
//  PersistableData.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/12/24.
//

import Foundation
import SwiftData

protocol StringIdentifiable: Identifiable where ID == String {}

protocol PersistableData: PersistentModel {
    associatedtype DomainModel: StringIdentifiable
    
    var remoteId: String { get }
}
