//
//  A.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import Combine
import SwiftUI

struct A: View, Coordinator {
    
    let id = UUID()
    //var parentCoordinator:
    var childCoordinators: [UUID : Coordinator] = [:]
    @StateObject private var router = Router<MainPath>()
    
    init() {}
    
    func start() {
        print("start coordinator")
    }
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            VStack {
                Text("This is A!")
                Button("Go to B") {
                    goToB()
                }
                Button("Go to E") {
                    goToE()
                }
            }
            .navigationDestination(for: MainPath.self) { path in
                createViewFromPath(path)
            }
        }
    }
    
    func goToB() {
        router.push(MainPath.b)
    }
    
    func goToE() {
        router.popToRoot()
        router.push([.b, .c, .d, .e])
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: MainPath) -> some View {
        switch path {
        case .a: createAView()
        case .b: createBView()
        case .c: createCView()
        case .d: createDView()
        case .e: createEView()
        }
    }
    
    private func createAView() -> A {
        let viewModel = ViewModelA()
        let view = A()
        return view
    }
    
    private func createBView() -> B {
        let viewModel = ViewModelB()
        let view = B()
        return view
    }
    
    private func createCView() -> C {
        let viewModel = ViewModelC()
        let view = C()
        return view
    }
    
    private func createDView() -> D {
        let viewModel = ViewModelD()
        let view = D()
        return view
    }
    
    private func createEView() -> E {
        let viewModel = ViewModelE()
        let view = E()
        return view
    }
}

struct A_Previews: PreviewProvider {
    static var previews: some View {
        A()
    }
}
