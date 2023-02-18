//
//  ViewModelB.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol BCoordinatorDelegate: AnyObject {
    
}

protocol ViewModelBProtocol: ObservableObject {
    
}

final class ViewModelB: ViewModelBProtocol {
    
    weak var coordinator: BCoordinatorDelegate?
    
}
