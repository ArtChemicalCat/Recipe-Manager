//
//  SearchRecipeUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation

final class SearchRecipeUseCase: UseCase {
    let viewModel: RecipeSearchViewModel
    let query: String
    let requestManager: RequestManagerProtocol = RequestManager()
    
    init(viewModel: RecipeSearchViewModel, query: String) {
        self.viewModel = viewModel
        self.query = query
    }
        
    func start() {
        viewModel.isLoading = true
        Task {
            do {
                let searchResults: SearchResultsDTO = try await requestManager.perform(RecipeRequest.searchBy(query: query))
                let recipes = searchResults.results.map { $0.toDomainRecipeShort() }
                viewModel.recipe = recipes
                viewModel.isLoading = false
            } catch {
                viewModel.errorMessageToPresent = error.localizedDescription
                viewModel.isLoading = false
            }
        }
    }
}
