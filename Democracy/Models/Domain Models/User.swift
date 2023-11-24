//
//  User.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Appwrite
import Foundation
import SwiftData

struct User: Codable, Identifiable {
    let accessedAt: Date?
    let createdAt: Date?
    let email: String
    let emailVerification: Bool
    let id: String
    let labels: [String]
    let name: String
    let passwordUpdate: Date?
    let phone: String
    let phoneVerification: Bool
    let prefs: [String] // TODO: ...
    let registration: Date?
    let status: Bool
    let updatedAt: Date?
    
    init(
        accessedAt: Date?,
        createdAt: Date?,
        email: String,
        emailVerification: Bool,
        id: String,
        labels: [String],
        name: String,
        passwordUpdate: Date?,
        phone: String,
        phoneVerification: Bool,
        prefs: [String],
        registration: Date?,
        status: Bool,
        updatedAt: Date?
    ) {
        self.accessedAt = accessedAt
        self.createdAt = createdAt
        self.email = email
        self.emailVerification = emailVerification
        self.id = id
        self.labels = labels
        self.name = name
        self.passwordUpdate = passwordUpdate
        self.phone = phone
        self.phoneVerification = phoneVerification
        self.prefs = prefs
        self.registration = registration
        self.status = status
        self.updatedAt = updatedAt
    }
}

extension Appwrite.User {
    
    func toUser() -> User {
        let formatter = ISO8601DateFormatter.sharedWithFractionalSeconds
        
        return .init(
            accessedAt: formatter.date(from: accessedAt),
            createdAt: formatter.date(from: createdAt),
            email: email,
            emailVerification: emailVerification,
            id: id,
            labels: [],
            name: name,
            passwordUpdate: formatter.date(from: passwordUpdate),
            phone: phone,
            phoneVerification: phoneVerification,
            prefs: [],
            registration: formatter.date(from: registration),
            status: status,
            updatedAt: formatter.date(from: updatedAt)
        )
    }
}
