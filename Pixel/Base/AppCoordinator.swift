//
//  AppCoordinator.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewModel: HomeViewModel = .init()
        let viewController: HomeViewController = .init(viewModel: viewModel)

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
