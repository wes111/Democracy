//
//  User.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

// Matches Appwrite User.
struct User: Codable {
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
    let prefs: [String] //TODO...
    let registration: Date?
    let status: Bool
    let updatedAt: Date?
}
