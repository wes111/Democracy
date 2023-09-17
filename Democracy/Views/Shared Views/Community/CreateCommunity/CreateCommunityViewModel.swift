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

final class CreateCommunityViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var categoryString = ""
    @Published var categories: [String] = []
    @Published var alert: CreateCommunityAlert?
    @Published var isLoading: Bool = false
    
    @Injected(\.communityInteractor) var communityInteractor
    
    let coordinator: CreateCommunityCoordinatorDelegate
    
    init(coordinator: CreateCommunityCoordinatorDelegate) {
        self.coordinator = coordinator
    }
}

//MARK: - Methods
extension CreateCommunityViewModel {
    
    func close() {
        coordinator.close()
    }
    
    func submitCategory() async {
        guard !categoryString.isEmpty && !categories.contains(categoryString) else { return }
        
        await MainActor.run {
            categories.append(categoryString)
            categoryString = ""
        }
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
