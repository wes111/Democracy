//
//  PostLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

@Observable
final class PostPrimaryLinkViewModel: UserTextInputViewModel {
    typealias Requirement = PostLinkRequirement
    
    var isShowingProgress: Bool = false
    var text: String = ""
    var textErrors: [Requirement] = []
    var alertModel: NewAlertModel?
    
    @ObservationIgnored @Injected(\.richLinkService) private var richLinkService
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    
    let field = SubmitPostField.primaryLink
    weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
}

// MARK: Computed Properties
extension PostPrimaryLinkViewModel {
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    @MainActor
    var skipAction: (() -> Void)? {
        skip
    }
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
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    @MainActor
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
        _ = try await richLinkService.getMetadata(for: url)
    }
    
    @MainActor
    func skip() {
        submitPostInput.primaryLink = nil
        coordinator?.didSubmitLink(input: submitPostInput)
    }
}
