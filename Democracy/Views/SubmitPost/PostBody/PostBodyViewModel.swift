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

final class PostBodyViewModel: UserTextInputViewModel {
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Requirement] = []
    @Published var alertModel: NewAlertModel?
    @Published var selectedTab: PostBodyTab = .editor
    
    typealias Requirement = NoneRequirement
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil // Not skippable.
    let field = SubmitPostField.body
    
    init(coordinator: SubmitPostCoordinatorDelegate, submitPostInput: SubmitPostInput) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
        
        setupBindings()
    }
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
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
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    func onAppear() {
        text = submitPostInput.body ?? ""
    }
}
