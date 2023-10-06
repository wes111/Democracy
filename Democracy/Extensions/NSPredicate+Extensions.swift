//
//  NSPredicate+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

extension NSPredicate {
    static func validate(string: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string)
    }
}
