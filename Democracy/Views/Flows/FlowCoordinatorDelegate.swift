//
//  FlowCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/24.
//

import Foundation

@MainActor
protocol FlowCoordinatorDelegate: AnyObject {
    func close()
    func goBack()
}
