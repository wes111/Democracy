//
//  ViewModelC.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Foundation

protocol CCoordinatorDelegate: AnyObject {
    
}

protocol ViewModelCProtocol: ObservableObject {
    
}

final class ViewModelC: ViewModelCProtocol {
    
    weak var coordinator: CCoordinatorDelegate?
    
}
