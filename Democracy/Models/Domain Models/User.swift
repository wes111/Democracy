//
//  User.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

protocol Comrade {
    var id: UUID { get set }
    var userName: String { get set }
    var firstName: String? { get set }
    var lastName: String? { get set }
}

struct UserAccount: Comrade, Hashable {
    // TODO: Break into protocols so we can have different types of users (admins, leaders, regular, etc.)
    var id: UUID = UUID() // TODO: Change where id is assigned value.
    var userName: String
    var firstName: String?
    var lastName: String?
}
