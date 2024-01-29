//
//  InputFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/27/24.
//

import Foundation

protocol InputFlow: CaseIterable, Hashable, RawRepresentable where RawValue == Int {
    var title: String { get }
    var subtitle: String { get }
    var required: Bool { get }
}
