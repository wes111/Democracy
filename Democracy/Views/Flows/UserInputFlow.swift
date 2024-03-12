//
//  UserInputFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation

protocol UserInputFlow {
    associatedtype ID: CaseIterable
    
    var progress: Int { get }
    var title: String { get }
    var subtitle: String { get }
}
