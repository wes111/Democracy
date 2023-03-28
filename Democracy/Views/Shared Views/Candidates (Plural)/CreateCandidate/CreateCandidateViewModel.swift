//
//  CreateCandidateViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/27/23.
//

import Factory
import Foundation

protocol CreateCandidateCoordinatorDelegate {
    func closeCreateCandidateView()
}

protocol CreateCandidateViewModelProtocol: ObservableObject {
    var summary: String { get set }
    var link: String { get set }
    
    var alert: CreateCandidateAlert? { get set }
    var isLoading: Bool { get set }
    
    func close()
    func submitCandidate()
}

final class CreateCandidateViewModel: CreateCandidateViewModelProtocol {
    
    @Published var summary = ""
    @Published var link = ""
    
    @Published var alert: CreateCandidateAlert?
    @Published var isLoading: Bool = false
    
    @Injected(\.candidateInteractor) var candidateInteractor
    
    let coordinator: CreateCandidateCoordinatorDelegate
    
    init(coordinator: CreateCandidateCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator.closeCreateCandidateView()
    }
    
    func submitCandidate() {
        isLoading = true
        Task {
            do {
                try await candidateInteractor.submitCandidate()
            } catch {
                await MainActor.run {
                    alert = CreateCandidateAlert.missingBody
                }
                print("Failed to submit candidate, error: \(error)")
            }
            await MainActor.run {
                isLoading = false
                close()
            }
            
        }
    }
    
}
