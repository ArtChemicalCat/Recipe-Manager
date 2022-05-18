//
//  RecipeSearchUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 10.05.2022.
//

import Foundation
import PromiseKit

final class GetRandomRecipeUseCase: UseCase {
    let viewModel: RecipeSearchViewModel
    let requestManager: RequestManagerProtocol = RequestManager()
        
    init(viewModel: RecipeSearchViewModel) {
        self.viewModel = viewModel
    }
    
    func start() {
        viewModel.isLoading = true
        Task {
            do {
                let recipeContainer: RandomRecipeContainerDTO = try await requestManager.perform(RecipeRequest.randomRecipes)
                let recipes = recipeContainer.recipes.map { $0.toDomainRecipeShort() }
                viewModel.recipe = recipes
                viewModel.isLoading = false
            } catch {
                viewModel.errorMessageToPresent = error.localizedDescription
                print(error)
                viewModel.isLoading = false
            }
        }
    }
}
