//
//  PostLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

@MainActor @Observable
final class PostPrimaryLinkViewModel: SubmittableSkipableViewModel, SubmittableTextInputViewModel {
    typealias Requirement = LinkRequirement
    typealias FocusedField = PostFlow.ID
    
    @ObservationIgnored @Injected(\.richLinkService) private var richLinkService
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Post Primary Link"
    let field: PostFlow.ID = .primaryLink
    private let submitPostInput: SubmitPostInput
    private weak var flowCoordinator: SubmitPostFlowCoordinator?
    
    init(submitPostInput: SubmitPostInput, flowCoordinator: SubmitPostFlowCoordinator?) {
        self.submitPostInput = submitPostInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension PostPrimaryLinkViewModel {

    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        do {
            try await fetchLinkMetadata(for: text)
        } catch {
            print(error.localizedDescription)
            return alertModel = SubmitPostAlert.failedFetchingLinkMetadata.toNewAlertModel()
        }
        submitPostInput.primaryLink = text
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .primaryLink)
    }
    
    func onAppear() {
        text = submitPostInput.primaryLink ?? ""
    }
}

// MARK: Computed Properties
extension PostPrimaryLinkViewModel {
    @MainActor
    var skipAction: (() -> Void) {
        skip
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
    
    func skip() {
        submitPostInput.primaryLink = nil
        flowCoordinator?.didSubmit(flow: .primaryLink)
    }
}
