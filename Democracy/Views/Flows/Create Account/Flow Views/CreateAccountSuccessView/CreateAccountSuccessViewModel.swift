//
//  CreateAccountSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

final class CreateAccountSuccessViewModel: SuccessViewModel {
    
    let secondaryText: String = "Your account was created successfully!"
    let imageType: AppImage = .customImage(.bmw)
    let closeAction: () -> Void
    let continueAction: () -> Void
    let username: String
    
    init(
        closeAction: @escaping () -> Void,
        continueAction: @escaping () -> Void,
        username: String
    ) {
        self.closeAction = closeAction
        self.continueAction = continueAction
        self.username = username
    }
    
    var primaryText: String {
        "Welcome to Democracy,\n \(username)"
    }
    
    var primaryButtonInfo: ButtonInfo {
        .init(title: "Continue Account Setup", action: continueAction)
    }
    
    var secondaryButtonInfo: ButtonInfo? {
        .init(title: "Skip", action: closeAction)
    }
}
