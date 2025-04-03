//
//  AppCoordinator.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import UIKit

protocol Coordinator {
    func start()
    func presetUserDetailModal(user: User)
}

class AppCoordinator: Coordinator {
    private let window: UIWindow
    
    private var rootViewController: UIViewController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let networkManager: NetworkAbstraction = NetworkManager()
        let viewModel: HomeViewModel = .init(coordinator: self, networkManager: networkManager)
        let viewController: HomeViewController = .init(viewModel: viewModel)

        rootViewController = viewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func presetUserDetailModal(user: User) {
        let viewModel: UserDetailViewModel = .init(user: user)
        let viewController: UserDetailViewController = .init(viewModel: viewModel)
        viewController.modalPresentationStyle = .automatic
        rootViewController?.present(viewController, animated: true)
    }
}
