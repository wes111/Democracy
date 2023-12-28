//
//  OnboardingAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/15/23.
//

import Foundation

protocol AlertModelProtocol {
    var title: String { get }
    var description: String { get }
    
    func toNewAlertModel() -> NewAlertModel
}

extension AlertModelProtocol {
    func toNewAlertModel() -> NewAlertModel {
        .init(title: title, description: description)
    }
}

struct NewAlertModel: Identifiable {
    var title: String
    var description: String
    
    var id: String {
        title
    }
    
    static let genericAlert = Self.init(
        title: "Error",
        description: "An error occurred, please try again later."
    )
}
