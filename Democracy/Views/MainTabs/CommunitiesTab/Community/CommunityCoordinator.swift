//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

enum CommunityPath: Hashable {
    case one
    case postView(Post)
}

struct CommunityCoordinator: View {
    
    private let router: Router
    private let community: Community
    
    init(_ community: Community,
         _ router: Router
    ) {
        self.community = community
        self.router = router
    }
    
    var body: some View {
        createCommunityView()
            .navigationDestination(for: CommunityPath.self) { path in
                createViewFromPath(path)
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunityPath) -> some View {
        switch path {
        case .one: Text("")
        case .postView(let post): createPostView(post: post)
        }
    }
    
    func createCommunityView() -> CommunityView<CommunityViewModel> {
        let viewModel = CommunityViewModel(coordinator: self, community: community)
        return CommunityView(viewModel: viewModel)
    }
    
    func createPostView(post: Post) -> PostView<PostViewModel> {
        let coordinator = PostCoordinator(post)
        let viewModel = PostViewModel(coordinator: coordinator, post: post)
        return PostView(viewModel: viewModel)
    }
}

extension CommunityCoordinator: CommunityCoordinatorDelegate {
    
    func go() {
        print("go")
    }
    
}

extension CommunityCoordinator: CommunityHomeFeedCoordinatorDelegate {
    
    func goToPostView(_ post: Post) {
        router.push(CommunityPath.postView(post))
    }
    
}

struct CommunityCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let community = Community(name: "Test Community", foundedDate: Date())
        let router = Router()
        CommunityCoordinator(community, router)
    }
}
