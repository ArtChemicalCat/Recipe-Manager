//
//  RecipeSearchCoordinator.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 09.06.2022.
//

import UIKit

final class RecipeSearchCoordinator: Coordinator {
    //MARK: - Properties
    var children: [Coordinator] = []
    var router: Router
        
    //MARK: - Initialiser
    init(router: Router) {
        self.router = router
    }
    //MARK: - Coordinator
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let actions = RecipeSearchViewActions(navigateToRecipeDetailView: navigateToRecipeDetailView(_:))
        let viewModel = RecipeSearchViewModel(actions: actions)
        let vc = RecipeSearchViewController(viewModel: viewModel)
        router.present(vc, animated: animated, onDismissed: onDismissed)
    }
    
    //MARK: - Metods
    private func navigateToRecipeDetailView(_ recipe: RecipeShort) {
        let actions = RecipeDetailViewActions(navigateToNutritionInfoView: navigateToNutritionInfoView(_:))
        let viewModel = RecipeDetailViewModel(recipe: recipe, actions: actions)
        let vc = RecipeDetailViewController(viewModel: viewModel)
        router.present(vc, animated: true)
    }
    
    private func navigateToNutritionInfoView(_ nutrients: [Nutrient]) {
        let viewModel = NutritionInfoViewModel(nutrients: nutrients)
        let vc = NutritionInfoViewController(viewModel: viewModel)
        router.present(vc, animated: true)
    }
}
