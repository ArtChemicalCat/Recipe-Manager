//
//  RecipeSearchUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 10.05.2022.
//

import Foundation

final class GetRandomRecipeUseCase: UseCase {
    let requestManager: RequestManagerProtocol = RequestManager()
    private let completionBlock: (Result<[RecipeShort], Error>) -> Void
    
    init(completion: @escaping (Result<[RecipeShort], Error>) -> Void) {
        self.completionBlock = completion
    }
    
    func start() {
        
        Task {
            do {
                let recipeContainer: RandomRecipeContainerDTO = try await requestManager.perform(RecipeRequest.randomRecipes)
                let recipes = recipeContainer.recipes.map { $0.toDomainRecipeShort() }
                completionBlock(.success(recipes))
            } catch {
                print(error)
                completionBlock(.failure(error))
            }
        }
    }
}
