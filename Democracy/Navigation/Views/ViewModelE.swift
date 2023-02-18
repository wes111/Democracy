//
//  ViewModelE.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol ECoordinatorDelegate: AnyObject {
    
}

protocol ViewModelEProtocol: ObservableObject {
    
}

final class ViewModelE: ViewModelEProtocol {
    
    weak var coordinator: ECoordinatorDelegate?
    
}
