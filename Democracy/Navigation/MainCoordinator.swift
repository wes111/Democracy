//
//  A.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

enum MainPath: Hashable {
    //case b
    case c
    case d
    case e
}

protocol MainCoordinatorParent: Coordinator {
    
}

protocol Coordinator {
    var id: UUID { get }
    //var childCoordinators: [UUID: Coordinator] { get set }
    //var parentCoordinator: Coordinator? { get }
    func start()
}

// This is just practice. Not to be used as is.
struct MainCoordinator: View, Coordinator {
    
    @EnvironmentObject private var router: Router
    let id = UUID()
    //let parentCoordinator: Coordinator? // TODO: Should this be a specific type?
    //var childCoordinators: [UUID : Coordinator] = [:]
    
    func start() {
        print("start coordinator")
    }
    
    var body: some View {
        createBView()
            .navigationDestination(for: MainPath.self) { path in
                createViewFromPath(path)
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: MainPath) -> some View {
        switch path {
        //case .b: createBView()
        case .c: createCView()
        case .d: createDView()
        case .e: createEView()
        }
    }
    
    private func createRootView() {
        
    }
    
    private func createBView() -> B<ViewModelB> {
        let viewModel = ViewModelB(coordinator: self)
        return B(viewModel: viewModel)
    }
    
    private func createCView() -> C<ViewModelC> {
        let viewModel = ViewModelC(coordinator: self)
        return C(viewModel: viewModel)
    }
    
    private func createDView() -> D<ViewModelD> {
        let viewModel = ViewModelD(coordinator: self)
        return D(viewModel: viewModel)
    }
    
    private func createEView() -> E<ViewModelE> {
        let viewModel = ViewModelE(coordinator: self)
        return E(viewModel: viewModel)
    }
}

extension MainCoordinator: BCoordinatorDelegate {
    
    func BToC() {
        router.push(MainPath.c)
    }
    
    func BToD() {
        router.push([MainPath.c, MainPath.d])
    }
    
    func BToE() {
        router.push([MainPath.c, MainPath.d, MainPath.e])
    }
}

extension MainCoordinator: CCoordinatorDelegate {
    func CToB() {
        router.pop()
    }
    
    func CToD() {
        router.push(MainPath.d)
    }
    
    func CToE() {
        router.push([MainPath.d, MainPath.e])
    }
    
}

extension MainCoordinator: DCoordinatorDelegate {
    func DToB() {
        router.popToRoot()
    }
    
    func DToC() {
        router.pop()
    }
    
    func DToE() {
        router.push(MainPath.e)
    }
    
}

extension MainCoordinator: ECoordinatorDelegate {
    
    func EToB() {
        router.popToRoot()
    }
    
    func EToC() {
        router.pop(count: 2)
    }
    
    func EToD() {
        router.pop()
    }
    
    
}

struct MainCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinator()
    }
}
