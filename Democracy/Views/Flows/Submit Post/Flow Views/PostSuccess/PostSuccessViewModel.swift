//
//  PostSuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import Foundation

final class PostSuccessViewModel: SuccessViewModel, Hashable {
    let closeAction: () -> Void
    let imageType: AppImage = .systemImage(.checkmarkDiamondFill)
    let secondaryButtonInfo: ButtonInfo? = nil
    let primaryText: String = "Your post has been submitted!"
    let secondaryText: String =  """
    Your post has been submitted and is currently under review. \
    Once approved, your post will be visible to the entire community.
    """
    
    init(closeAction: @escaping () -> Void) {
        self.closeAction = closeAction
    }
    
    var primaryButtonInfo: ButtonInfo {
        .init(title: "Finish", action: closeAction)
    }
}
