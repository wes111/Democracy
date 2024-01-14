//
//  PostLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

final class PostPrimaryLinkViewModel: UserTextInputViewModel {
    @Injected(\.richLinkService) private var richLinkService
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Requirement] = []
    @Published var alertModel: NewAlertModel?
    
    typealias Requirement = PostLinkRequirement
    let field = SubmitPostField.primaryLink
    private let submitPostInput: SubmitPostInput
    weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
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
    
    lazy var skipAction: (() -> Void)? = {{
        self.submitPostInput.primaryLink = nil
        self.coordinator?.didSubmitLink(input: self.submitPostInput)
    }}()
}

// MARK: - Methods
extension PostPrimaryLinkViewModel {
    
    @MainActor
    func submit() async {
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        do {
            try await fetchLinkMetadata(for: text)
        } catch {
            print(error.localizedDescription)
            return alertModel = SubmitPostAlert.failedFetchingLinkMetadata.toNewAlertModel()
        }
        submitPostInput.primaryLink = text
        coordinator?.didSubmitLink(input: submitPostInput)
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
        text = submitPostInput.primaryLink ?? ""
    }
}

// MARK: - Private Methods
private extension PostPrimaryLinkViewModel {
    
    func fetchLinkMetadata(for urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw GenericError.defaultError
        }
        let bob = try await richLinkService.getMetadata(for: url)
        print(bob)
    }
}
