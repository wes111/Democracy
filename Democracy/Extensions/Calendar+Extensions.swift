//
//  Calendar+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/13/23.
//

import Foundation

extension Calendar {
    
    func addDaysToNow(dayCount: Int) -> Date {
        self.date(byAdding: .day, value: dayCount, to: .now)!
    }
}
