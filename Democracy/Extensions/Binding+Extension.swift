//
//  Binding+Extension.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/17/24.
//

import SwiftUI

extension Binding where Value == Bool {
    init<Wrapped>(bindingOptional: Binding<Wrapped?>) {
        self.init {
            bindingOptional.wrappedValue != nil
        } set: { newValue in
            guard newValue == false else {
                return
            }
            bindingOptional.wrappedValue = nil
        }
    }
}

extension Binding {
    public func mappedToBool<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        Binding<Bool>(bindingOptional: self)
    }
}
