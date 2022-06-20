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
        let useCase = GetRandomRecipeUseCase(completion: handleApiResponse(result:))
        useCase.start()
        isLoading = true
    }
    
    func search() {
        let request: RecipeRequest = .searchBy(query: searchQuery, cuisine: cuisineType, diet: dietType)
        let useCase = SearchRecipeUseCase(request: request, completion: handleApiResponse(result:))
        useCase.start()
        isLoading = true
    }
    
    private func handleApiResponse(result: Result<[RecipeShort], Error>) {
        defer { isLoading = false }
        
        switch result {
        case .success(let recipes):
            self.recipe = recipes
        case .failure(let error):
            errorMessageToPresent = error.localizedDescription
        }
    }
    
}

