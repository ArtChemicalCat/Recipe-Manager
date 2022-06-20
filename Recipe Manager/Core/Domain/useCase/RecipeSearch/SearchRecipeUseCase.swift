//
//  SearchRecipeUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation

final class SearchRecipeUseCase: UseCase {
    let requestManager: RequestManagerProtocol = RequestManager()
    private let completionBlock: (Result<[RecipeShort], Error>) -> Void
    private let request: RequestProtocol
    
    init(request: RequestProtocol, completion: @escaping (Result<[RecipeShort], Error>) -> Void) {
        completionBlock = completion
        self.request = request
    }
        
    func start() {
        Task {
            do {
                let searchResults: SearchResultsDTO = try await requestManager
                    .perform(request)
                let recipes = searchResults.results.map { $0.toDomainRecipeShort() }
                completionBlock(.success(recipes))
            } catch {
                completionBlock(.failure(error))
            }
        }
    }
}
