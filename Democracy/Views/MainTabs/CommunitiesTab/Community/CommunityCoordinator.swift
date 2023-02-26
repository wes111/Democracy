//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

enum CommunityPath {
    case one
}

struct CommunityCoordinator: View {
    
    @EnvironmentObject private var router: Router
    private let community: Community
    
    init(_ community: Community) {
        self.community = community
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
        }
    }
    
    func createCommunityView() -> CommunityView<CommunityViewModel> {
        let viewModel = CommunityViewModel(coordinator: self, community: community)
        return CommunityView(viewModel: viewModel)
    }
}

extension CommunityCoordinator: CommunityCoordinatorDelegate {
    
    func go() {
        print("go")
    }
    
}

struct CommunityCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let community = Community(name: "Test Community", foundedDate: Date())
        CommunityCoordinator(community)
    }
}
