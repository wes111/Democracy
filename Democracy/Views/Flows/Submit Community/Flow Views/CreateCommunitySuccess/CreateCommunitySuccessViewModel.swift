//
//  CreateCommunitySuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/24.
//

import Foundation

@MainActor
final class CreateCommunitySuccessViewModel: SuccessViewModel, Hashable {
    
    let secondaryText: String = "The community was created successfully!"
    let imageType: AppImage = .systemImage(.checkmarkDiamondFill)
    let secondaryButtonInfo: ButtonInfo? = nil
    let closeAction: () -> Void
    private let communityName: String
    
    init(communityName: String, closeAction: @escaping () -> Void) {
        self.communityName = communityName
        self.closeAction = closeAction
    }
    
    var primaryText: String {
        "\(communityName)\n was created successfully!"
    }
    
    var primaryButtonInfo: ButtonInfo {
        .init(title: "Finish", action: closeAction)
    }
}
