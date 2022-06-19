//
//  RecipeSearchRouter.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 09.06.2022.
//

import UIKit

final class RecipeSearchRouter: Router {
    private let navigationController: UINavigationController
    private var onDismissed: [UIViewController: () -> Void] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    //MARK: - Router
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        navigationController.pushViewController(viewController, animated: animated)
        self.onDismissed[viewController] = onDismissed
    }
    
    func dismiss(animated: Bool) {}
}
