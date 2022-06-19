//
//  RecipeSearchViewModel.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 10.05.2022.
//

import Foundation

final class RecipeSearchViewActions {
    let navigateToRecipeDetailView: (RecipeShort) -> Void
    
    init(navigateToRecipeDetailView: @escaping (RecipeShort) -> Void) {
        self.navigateToRecipeDetailView = navigateToRecipeDetailView
    }
}

class RecipeSearchViewModel {
    //MARK: - Properties
    
    var cuisineType: Cuisine = .none
    var dietType: Diet = .none
    var searchQuery = ""
    
    var actions: RecipeSearchViewActions!
    
    //MARK: - Initialisers
    init(actions: RecipeSearchViewActions) {
        self.actions = actions
    }
    
    //MARK: - Published
    @Published var recipe: [RecipeShort] = []
    @Published var errorMessageToPresent: String?
    @Published var isLoading = false
    
//MARK: - Metods
    func fetchRandomRecipe() {
        let useCase = GetRandomRecipeUseCase(viewModel: self)
        useCase.start()
    }
    
    func search() {
        let useCase = SearchRecipeUseCase(viewModel: self)
        useCase.start()
    }
    
}

