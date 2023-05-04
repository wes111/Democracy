//
//  Date+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/3/23.
//

import Foundation

extension Date {
    
    static var creationDate: Date {
        Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 1))!
    }
}
