//
//  Session.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/7/23.
//

import Appwrite
import Foundation

struct Session: Codable, Identifiable {
    let id: String
    let createdAt: Date?
    let userId: String
    let expirationDate: Date
    let provider: String // TODO: This should be an enum: "email", etc..
    let providerUid: String
    let providerAccessToken: String
    let providerAccessTokenExpirationDate: Date?
    let providerRefreshToken: String
    let countryCode: String // TODO: Should be enum.
    let current: Bool // Returns true if this is the current user session.
}

extension Appwrite.Session {
    
    func toSession() -> Session {
        let formatter = ISO8601DateFormatter.sharedWithFractionalSeconds
        
        return .init(
            id: id,
            createdAt: formatter.date(from: createdAt),
            userId: userId,
            expirationDate: formatter.date(from: expire) ?? .now,
            provider: provider,
            providerUid: providerUid,
            providerAccessToken: providerAccessToken,
            providerAccessTokenExpirationDate: formatter.date(from: providerAccessTokenExpiry),
            providerRefreshToken: providerRefreshToken,
            countryCode: countryCode,
            current: current
        )
    }
}
