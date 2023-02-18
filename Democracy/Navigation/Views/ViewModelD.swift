//
//  ViewModelD.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol DCoordinatorDelegate: AnyObject {
    
}

protocol ViewModelDProtocol: ObservableObject {
    
}

final class ViewModelD: ViewModelDProtocol {
    
    weak var coordinator: DCoordinatorDelegate?
    
}
