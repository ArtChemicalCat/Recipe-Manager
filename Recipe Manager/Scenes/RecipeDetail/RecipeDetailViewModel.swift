//
//  RecipeDetailViewModel.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation

final class RecipeDetailViewModel {
    let recipe: RecipeShort
    let recipeDetailUseCaseFactory: RecipeDetailUseCaseFactory

    @Published var instructions: Instructions?
    @Published var recipeInfo: Recipe?
    @Published var isLoading = false
    
    init(recipe: RecipeShort, recipeDetailUseCaseFactory: RecipeDetailUseCaseFactory) {
        self.recipe = recipe
        self.recipeDetailUseCaseFactory = recipeDetailUseCaseFactory
    }
    
    func getRecipeInfo() {
        let useCase = recipeDetailUseCaseFactory.makeRecipeInfoUseCase(id: recipe.id, viewModel: self)
        useCase.start()
    }
    
}


