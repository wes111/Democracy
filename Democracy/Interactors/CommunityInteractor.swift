//
//  CommunityInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Combine
import Factory

protocol CommunityInteractorProtocol {

}

struct CommunityInteractor: CommunityInteractorProtocol {
    
    @Injected(\.communityLocalRepository) var localRepository
    @Injected(\.communityRemoteRepository) var remoteRepository
    
    init() {
        
    }
    
}

