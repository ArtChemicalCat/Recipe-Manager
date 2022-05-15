//
//  RecipeSearchViewModel.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 10.05.2022.
//

import Foundation

class RecipeSearchViewModel {
    //MARK: - Properties
    let recipeSearchUseCaseFactory: RecipeSearchUseCaseFactory
    
    //MARK: - Initializers
    init(useCaseFactory: RecipeSearchUseCaseFactory) {
        self.recipeSearchUseCaseFactory = useCaseFactory
    }
        
    @Published var recipe: [RecipeShort] = []
    @Published var errorMessageToPresent: String?
    @Published var isLoading = false
    
    func fetchRandomRecipe() {
        let useCase = recipeSearchUseCaseFactory.makeGetRandomRecipeUseCase()
        useCase.start()
    }
    
    func search(recipeBy query: String) {
        let useCase = recipeSearchUseCaseFactory.makeSearchRecipeUseCase(query: query)
        useCase.start()
    }
    
}

