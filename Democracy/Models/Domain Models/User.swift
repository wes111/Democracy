//
//  User.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

struct UserAccount: Hashable { // TODO: Break into protocols so we can have different types of users (admins, leaders, regular, etc.)
    let id: UUID = UUID() // TODO: Change where id is assigned value.
    let firstName: String
    let lastName: String
}
