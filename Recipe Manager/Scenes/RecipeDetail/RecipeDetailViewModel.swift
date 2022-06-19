//
//  RecipeDetailViewModel.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation

final class RecipeDetailViewActions {
    let navigateToNutritionInfoView: ([Nutrient]) -> Void
    
    init(navigateToNutritionInfoView: @escaping ([Nutrient]) -> Void) {
        self.navigateToNutritionInfoView = navigateToNutritionInfoView
    }
}

final class RecipeDetailViewModel {
    let recipe: RecipeShort
    
    let actions: RecipeDetailViewActions

    @Published var instructions: Instructions?
    @Published var recipeInfo: Recipe?
    @Published var isLoading = false
    
    init(recipe: RecipeShort, actions: RecipeDetailViewActions) {
        self.recipe = recipe
        self.actions = actions
    }
    
    func getRecipeInfo() {
        let useCase = RecipeInfoUseCase(viewModel: self, recipeID: recipe.id)
        useCase.start()
    }
}


