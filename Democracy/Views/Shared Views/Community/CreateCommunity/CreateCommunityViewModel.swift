//
//  CreateCommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/3/23.
//

import Foundation

import Combine
import Factory

protocol CreateCommunityCoordinatorDelegate {
    func close()
}

protocol CreateCommunityViewModelProtocol: ObservableObject {
    var title: String { get set }
    var alert: CreateCommunityAlert? { get set }
    var isLoading: Bool { get set }
    
    func close()
    func submitCommunity()
}

final class CreateCommunityViewModel: CreateCommunityViewModelProtocol {
    
    @Published var title = ""
    @Published var alert: CreateCommunityAlert?
    @Published var isLoading: Bool = false
    
    @Injected(\.communityInteractor) var communityInteractor
    
    let coordinator: CreateCommunityCoordinatorDelegate
    
    init(coordinator: CreateCommunityCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator.close()
    }
    
    func submitCommunity() {
        isLoading = true
        Task {
            do {
                try await communityInteractor.submitCommunity(title: title)
            } catch {
                await MainActor.run {
                    alert = .missingTitle
                }
                print(error)
            }
            await MainActor.run {
                isLoading = false
                close()
            }
            
        }
    }
    
}
