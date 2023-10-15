//
//  OnboardingAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/15/23.
//

import Foundation

struct OnboardingAlert: Identifiable {
    
    var id: String {
        title
    }
    
    let title: String
    let message: String
}
