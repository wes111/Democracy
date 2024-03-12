//
//  PostInputFlowViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation

extension PostInputFlowViewModel {
    static let preivew = PostInputFlowViewModel(coordinator: .preview)
}

extension PostTitleViewModel {
    static let preview = PostTitleViewModel(
        input: .init(),
        flowCoordinator: PostInputFlowViewModel.preivew
    )
}

extension PostPrimaryLinkViewModel {
    static let preview = PostPrimaryLinkViewModel(
        submitPostInput: .init(),
        flowCoordinator: PostInputFlowViewModel.preivew
    )
}

extension PostBodyViewModel {
    static let preview = PostBodyViewModel(
        submitPostInput: .init(),
        flowCoordinator: PostInputFlowViewModel.preivew
    )
}

extension PostCategoryViewModel {
    static let preview = PostCategoryViewModel(
        submitPostInput: .init(),
        flowCoordinator: PostInputFlowViewModel.preivew
    )
}

extension PostTagsViewModel {
    static let preview = PostTagsViewModel(
        submitPostInput: .init(),
        flowCoordinator: PostInputFlowViewModel.preivew
    )
}
