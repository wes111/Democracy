//
//  UserTextEditorInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

enum PostBodyTab: String, CaseIterable, Equatable {
    case editor, preview
}

protocol UserTextEditorInputViewModel: UserTextInputViewModel {
    var selectedTab: PostBodyTab { get set }
    var markdown: AttributedString { get }
}
