//
//  PostLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

final class PostLinkViewModel: UserTextInputViewModel {
    typealias Field = PostLinkValidator
    
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
    @Injected(\.richLinkService) private var richLinkService
    
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
}

// MARK: - Methods
extension PostLinkViewModel {
    
    @MainActor
    func submit() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        do {
            try await fetchLinkMetadata(for: text)
        } catch {
            print(error.localizedDescription)
            return alertModel = SubmitPostAlert.failedFetchingLinkMetadata.toNewAlertModel()
        }
        submitPostInput.link = text
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
    
    func skip() {
        submitPostInput.link = nil
        coordinator?.didSubmitLink(input: submitPostInput)
    }
    
    func onAppear() {
        text = submitPostInput.link ?? ""
    }
}

// MARK: - Private Methods
private extension PostLinkViewModel {
    
    func fetchLinkMetadata(for urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw GenericError.defaultError
        }
        let bob = try await richLinkService.getMetadata(for: url)
        print(bob)
    }
}
