//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import SwiftUI

enum CommunityPath: Hashable {
    case one
    case postView(Post)
    case candidates
    case singleCandidate(Candidate)
    case goToCommunity(Community)
    case goToCommunityPostCategory(category: CommunityCategory)
}

struct CommunityCoordinator: View {
    
    @StateObject private var viewModel: CommunityCoordinatorViewModel
    @ObservedObject private var router: Router
    
    init(viewModel: CommunityCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        router = viewModel.router
    }
    
    var body: some View {
        CommunityViewPicker(viewModel: viewModel.communityViewModel)
            .navigationDestination(for: CommunityPath.self) { path in
                createViewFromPath(path)
            }
            .fullScreenCover(isPresented: $viewModel.isShowingCreatePostView) {
                AddPostView(viewModel: viewModel.addPostViewModel)
            }
            .sheet(isPresented: $viewModel.isShowingWebView) {
                WebView(url: $viewModel.url)
            }
            .fullScreenCover(isPresented: $viewModel.isShowingCreateCandidateView) {
                CreateCandidateView(viewModel: viewModel.createCandidateViewModel)
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunityPath) -> some View {
        switch path {
            
        case .one: Text("")
            
        case .postView(let post):
            PostView(viewModel: viewModel.postViewModel(post: post))
            
        case .candidates:
            CandidatesView(viewModel: viewModel.candidatesViewModel)
            
        case .singleCandidate(let candidate):
            CandidateView(viewModel: viewModel.candidateViewModel(candidate: candidate))
            
        case .goToCommunity:
            CommunityViewPicker(viewModel: viewModel.communityViewModel)
            
        case .goToCommunityPostCategory(let category): CommunityPostCategoryView(viewModel: viewModel.communityPostCategoryViewModel(category: category))
        }
    }
}

struct CommunityCoordinator_Previews: PreviewProvider {
    
    static var previews: some View {
        CommunityCoordinator.preview
    }
}
