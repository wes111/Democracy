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

@MainActor
protocol SubmittableTextEditorInputViewModel: SubmittableTextInputViewModel {
    var selectedTab: PostBodyTab { get set }
    var markdown: AttributedString { get }
}
