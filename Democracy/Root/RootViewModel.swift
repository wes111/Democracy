//
//  RootViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol RootViewModelProtocol: ObservableObject {
    var isAuthenticated: Bool { get }
}

class RootViewModel: RootViewModelProtocol {
    @Published var isAuthenticated: Bool = false
    
    init() {
        temp_authPublisher.assign(to: &$isAuthenticated)
    }
}
