//
//  AppCoordinator.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 09.06.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
        
    init(router: Router) {
        self.router = router
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let navigation = UINavigationController()
        router.present(navigation, animated: false)
        let recipeSearchRouter = RecipeSearchRouter(navigationController: navigation)
        let recipeSearchCoordinator = RecipeSearchCoordinator(router: recipeSearchRouter)
        
        presentChild(recipeSearchCoordinator, animated: true)
    }
}
