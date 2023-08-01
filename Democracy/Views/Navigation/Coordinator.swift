//
//  Coordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Combine
import Foundation

/// A Router typically belongs to an ObservableObject ViewModel. Since Router is also an ObservableObject, this
/// creates nested ObservableObjects, which do not work in SwiftUI. This class is a work-around and is intended to
/// be sub-classed by Coordinator ViewModels.
/// https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects
///
/// The top level Coordinator should not provide a Router instance in the initializer. Child Coordinators should provide
/// an instance of Router, and it will be the same Router owned by the top-level Coordinator.
class Coordinator: ObservableObject {
    
    @Published var router: Router
    private var cancellables = Set<AnyCancellable>()
    
    init(router: Router = Router()) {
        self._router = Published(wrappedValue: router)
        router.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        .store(in: &cancellables)
    }
}
