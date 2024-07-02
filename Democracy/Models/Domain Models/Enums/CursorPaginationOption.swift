//
//  CursorPaginationOption.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/15/24.
//

import Foundation

enum CursorPaginationOption {
    case before(id: String)
    case after(id: String)
    case initial
}
