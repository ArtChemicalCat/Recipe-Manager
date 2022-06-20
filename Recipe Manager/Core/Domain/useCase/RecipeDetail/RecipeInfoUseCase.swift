//
//  RecipeInfoUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 12.05.2022.
//

import Foundation

final class RecipeInfoUseCase: UseCase {
    //MARK: - Dependency
    private let requestManager: RequestManagerProtocol = RequestManager()
    //MARK: - Properties
    private let id: Int
    private let completionBlock: (Recipe, Instructions) -> Void
    
    //MARK: - Metods
    init(recipeID: Int, completion: @escaping (Recipe, Instructions) -> Void) {
        self.completionBlock = completion
        self.id = recipeID
    }
    
    func start() {
        Task {
            do {
                let recipeInfo: RecipeDTO = try await requestManager.perform(RecipeRequest.recipeBy(id: id))
                let instructions: [RecipeInstructionDTO] = try await requestManager.perform(RecipeRequest.instructionsForRecipe(id: id))
                completionBlock(recipeInfo.toDomainRecipe(), instructions.first!.toDomainInstruction())
            } catch {
                print(error)
            }
        }
    }
}

