//
//  Date+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/3/23.
//

import Foundation

extension Date {
    
    var yearInt: Int {
        return Calendar.current.dateComponents([.year], from: self).year!
    }
    
    var month: Month {
        let monthInt = Calendar.current.dateComponents([.month], from: self).month!
        return Month(rawValue: monthInt)!
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    /// Returns yesterday. A positive offset can be provided to specify how many days previous, where 0 is today.
    static func previousDay(offset: Int = 1) -> Date {
        Calendar.current.date(byAdding: .day, value: -offset, to: Date())!
    }
    
}

// Democracy related dates.
extension Date {
    
    // The date the app was created. TODO: This date should not be 2010
    static let creationDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1))!
    
    // An array containing the inclusive years between the app's creation date and today.
    static var yearsArraySinceCreation: [Int] {
        let creationYear = creationDate.yearInt
        let currentYear = Date().yearInt
        
        var yearsArray: [Int] = []
        
        for year in creationYear...currentYear {
            yearsArray.append(year)
        }
        
        return yearsArray
    }
    
}
