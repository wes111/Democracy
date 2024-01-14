//
//  PostSecondaryLinksViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import Factory
import Foundation

final class PostSecondaryLinksViewModel: UserTextInputViewModel {
    @Injected(\.richLinkService) private var richLinkService
    @Published var isShowingProgress: Bool = false
    @Published var alertModel: NewAlertModel?
    @Published var text: String = ""
    @Published var addedSecondaryLinks: [String] = []
    @Published var textErrors: [Requirement] = []
    
    typealias Requirement = PostLinkRequirement
    let field = SubmitPostField.secondaryLinks
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
        
        setupBindings()
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var skipAction: (() -> Void)? = {{
        self.submitPostInput.secondaryLinks = []
        self.coordinator?.didSubmitLink(input: self.submitPostInput)
    }}()
}

// MARK: - Computed Properties
extension PostSecondaryLinksViewModel {
    var canSubmit: Bool {
        field.fullyValid(input: text)
    }
}

// MARK: - Methods
extension PostSecondaryLinksViewModel {
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    @MainActor
    func addLinkToList() async {
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        
        do {
            try await fetchLinkMetadata(for: text)
        } catch {
            print(error.localizedDescription)
            return alertModel = SubmitPostAlert.failedFetchingLinkMetadata.toNewAlertModel()
        }
        
        addedSecondaryLinks.append(text)
        text = ""
    }
    
    func submit() {
        submitPostInput.secondaryLinks = addedSecondaryLinks
        coordinator?.didSubmitLink(input: submitPostInput)
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    func close() {
        coordinator?.close()
    }
    
    func onAppear() {
        addedSecondaryLinks = submitPostInput.secondaryLinks
    }
}

// MARK: - Private Methods
// TODO: Copy of function in PrimaryLinkViewModel
private extension PostSecondaryLinksViewModel {
    
    func fetchLinkMetadata(for urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw GenericError.defaultError
        }
        let bob = try await richLinkService.getMetadata(for: url)
        print(bob)
    }
}
