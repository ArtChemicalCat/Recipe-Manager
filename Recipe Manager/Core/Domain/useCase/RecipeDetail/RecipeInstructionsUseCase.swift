//
//  RecipeInstructionsUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation

final class RecipeInstructionsUseCase: UseCase {
    //MARK: - Properties
    let viewModel: RecipeDetailViewModel
    let requestManager: RequestManagerProtocol = RequestManager()
    
    let id: Int
    
    init(viewModel: RecipeDetailViewModel, recipeID: Int) {
        self.viewModel = viewModel
        self.id = recipeID
    }
    func start() {
        Task {
            do {
                let instructions: [RecipeInstructionDTO] = try await requestManager.perform(RecipeRequest.instructionsForRecipe(id: id))
                viewModel.instructions = instructions.first?.toDomainInstruction()
            } catch {
                print(error)
            }
        }
    }
}
