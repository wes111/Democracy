//
//  A.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

enum MainPath: Hashable {
    case b
    case c
    case d
    case e
}

protocol Coordinator {
    var id: UUID { get }
    var childCoordinators: [UUID: Coordinator] { get set }
    var parentCoordinator: Coordinator? { get }
    func start()
}

struct MainCoordinator: View, Coordinator {
    
    @StateObject private var router = Router<MainPath>()
    let id = UUID()
    let parentCoordinator: Coordinator? = nil
    var childCoordinators: [UUID : Coordinator] = [:]
    
    func start() {
        print("start coordinator")
    }
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            VStack {
                createBView()
            }
            .navigationDestination(for: MainPath.self) { path in
                createViewFromPath(path)
            }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: MainPath) -> some View {
        switch path {
        case .b: createBView()
        case .c: createCView()
        case .d: createDView()
        case .e: createEView()
        }
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
        router.push(.c)
    }
    
    func BToD() {
        router.push([.c, .d])
    }
    
    func BToE() {
        router.push([.c, .d, .e])
    }
}

extension MainCoordinator: CCoordinatorDelegate {
    func CToB() {
        router.pop()
    }
    
    func CToD() {
        router.push(.d)
    }
    
    func CToE() {
        router.push([.d, .e])
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
        router.push(.e)
    }
    
}

extension MainCoordinator: ECoordinatorDelegate {
    
    func EToB() {
        router.popToRoot()
    }
    
    func EToC() {
        router.pop(to: .c)
    }
    
    func EToD() {
        router.pop()
    }
    
    
}

struct A_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinator()
    }
}
