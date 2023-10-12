//
//  UpdatesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol UpdatesTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

protocol UpdatesTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class UpdatesTabMainViewModel: UpdatesTabMainViewModelProtocol {
    
    //private weak var coordinator: UpdatesTabMainCoordinatorDelegate?
    
    init() {
        //self.coordinator = coordinator
    }
    
    func tappedNav() {
        //coordinator?.tappedNav()
    }
}
