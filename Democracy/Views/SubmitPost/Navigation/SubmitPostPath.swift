//
//  SubmitPostPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

enum SubmitPostPath: Hashable {
    case goToPostBody(PostBodyViewModel)
    case goToPostPrimaryLink(PostPrimaryLinkViewModel)
    case goToPostTags(PostTagsViewModel)
    case goToPostCategory(PostCategoryViewModel)
    case goToPostSuccess(PostSuccessViewModel)
}
