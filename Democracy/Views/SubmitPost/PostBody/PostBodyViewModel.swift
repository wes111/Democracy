//
//  PostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

enum PostBodyTab: String, CaseIterable, Equatable {
    case editor, preview
}

@Observable
final class PostBodyViewModel: PostViewModel, UserTextInputViewModel {
    typealias Requirement = NoneRequirement
    var textErrors: [Requirement] = []
    var selectedTab: PostBodyTab = .editor
    
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    let skipAction: (() -> Void)? = nil // Not skippable.
    let field = SubmitPostField.body
    
    init(coordinator: SubmitPostCoordinatorDelegate, submitPostInput: SubmitPostInput) {
        self.submitPostInput = submitPostInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension PostBodyViewModel {
    
    // https://forums.developer.apple.com/forums/thread/682957
    var markdown: AttributedString {
        (try? AttributedString(
            markdown: text,
            options: AttributedString.MarkdownParsingOptions(
                interpretedSyntax: .inlineOnlyPreservingWhitespace
            )
        )) ?? .init()
    }
}

// MARK: - Methods
extension PostBodyViewModel {
    @MainActor
    func submit() async {
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        submitPostInput.body = text
        coordinator?.didSubmitBody(input: submitPostInput)
    }
    
    func onAppear() {
        text = submitPostInput.body ?? ""
    }
}
