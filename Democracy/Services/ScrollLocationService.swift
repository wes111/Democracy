//
//  ScrollLocationService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/4/23.
//

import Combine
import Foundation

/// The purpose of this class is to track the user's scroll location, making it easier to pass between view models.
protocol ScrollLocationServiceProtocol {
    
    func subscribeToLocations() -> AnyPublisher<CGPoint, Never>
    
    func updateScrollLocation(_ location: CGPoint)
}

final class ScrollLocationService: ScrollLocationServiceProtocol {
    
    private let locationSubject = CurrentValueSubject<CGPoint, Never>(CGPoint(x: 0, y: 0))
    
    func subscribeToLocations() -> AnyPublisher<CGPoint, Never> {
        locationSubject.eraseToAnyPublisher()
    }
    
    func updateScrollLocation(_ location: CGPoint) {
        locationSubject.send(location)
        //print("Location: \(location)") // This one is working.
    }
    
}
