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
final class PostBodyViewModel: UserTextInputViewModel {
    typealias Requirement = NoneRequirement
    
    var isShowingProgress: Bool = false
    var text: String = ""
    var textErrors: [Requirement] = []
    var alertModel: NewAlertModel?
    var selectedTab: PostBodyTab = .editor
    
    
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil // Not skippable.
    let field = SubmitPostField.body
    
    init(coordinator: SubmitPostCoordinatorDelegate, submitPostInput: SubmitPostInput) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
}

// MARK: - Computed Properties
extension PostBodyViewModel {
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
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
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    @MainActor
    func goBack() {
        coordinator?.goBack()
    }
    
    func onAppear() {
        text = submitPostInput.body ?? ""
    }
}
