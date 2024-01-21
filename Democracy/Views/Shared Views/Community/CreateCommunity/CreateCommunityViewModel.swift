//
//  CreateCommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/3/23.
//

import Foundation

import Combine
import Factory

@MainActor
protocol CreateCommunityCoordinatorDelegate: AnyObject {
    func close()
}

final class CreateCommunityViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var categoryString = ""
    @Published var postTagString = ""
    @Published var summary = ""
    @Published var categories: [String] = []
    @Published var postTags: [String] = []
    @Published var alert: CreateCommunityAlert?
    @Published var isLoading: Bool = false
    @Published var hasAdultContent = false
    
    @Injected(\.communityInteractor) var communityInteractor
    
    weak var coordinator: CreateCommunityCoordinatorDelegate?
    
    init(coordinator: CreateCommunityCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}

// MARK: - Methods
extension CreateCommunityViewModel {
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    func submitCategory() async {
//        guard !categoryString.isEmpty && !categories.contains(categoryString) else { return }
//        
//        await MainActor.run {
//            categories.append(categoryString)
//            categoryString = ""
//        }
    }
    
    func submitPostTag() async {
//        guard !postTagString.isEmpty && !postTags.contains(postTagString) else { return }
//        
//        await MainActor.run {
//            postTags.append(postTagString)
//            postTagString = ""
//        }
    }
    
    func submitCommunity() {
//        isLoading = true
//        Task {
//            do {
//                try await communityInteractor.submitCommunity(title: title)
//            } catch {
//                await MainActor.run {
//                    alert = .missingTitle
//                }
//                print(error)
//            }
//            await MainActor.run {
//                isLoading = false
//                close()
//            }
//            
//        }
    }
}
