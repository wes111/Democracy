//
//  Session+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

extension Session {
    
    static var preview: Session {
        .init(
            id: UUID().uuidString,
            createdAt: .now,
            userId: "123",
            expirationDate: .now,
            provider: "",
            providerUid: "",
            providerAccessToken: "",
            providerAccessTokenExpirationDate: nil,
            providerRefreshToken: "",
            countryCode: "",
            current: true
        )
    }
}
