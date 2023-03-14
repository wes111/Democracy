//
//  UserInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Combine
import Factory

protocol UserInteractorProtocol {

}

struct UserInteractor: UserInteractorProtocol {
    
    @Injected(\.userLocalRepository) var localRepository
    @Injected(\.userRemoteRepository) var remoteRepository
    
    init() {
        
    }
    
}

