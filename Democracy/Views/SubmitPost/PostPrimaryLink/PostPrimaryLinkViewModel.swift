//
//  PostLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

@Observable
final class PostPrimaryLinkViewModel: PostViewModel, UserTextInputViewModel {
    typealias Requirement = PostLinkRequirement
    var textErrors: [Requirement] = []
    
    @ObservationIgnored @Injected(\.richLinkService) private var richLinkService
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    let field = SubmitPostField.primaryLink
    let flowCase = SubmitPostFlow.primaryLink
    
    init(coordinator: SubmitPostCoordinatorDelegate, submitPostInput: SubmitPostInput) {
        self.submitPostInput = submitPostInput
        super.init(coordinator: coordinator)
    }
}

// MARK: Computed Properties
extension PostPrimaryLinkViewModel {
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
