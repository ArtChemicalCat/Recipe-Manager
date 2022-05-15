//
//  RecipeInfoUseCase.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 12.05.2022.
//

import Foundation

final class RecipeInfoUseCase: UseCase {
    //MARK: - Dependency
    let requestManager: RequestManagerProtocol = RequestManager()
    let viewModel: RecipeDetailViewModel
    //MARK: - Properties
    let id: Int
    
    //MARK: - Metods
    init(viewModel: RecipeDetailViewModel, recipeID: Int) {
        self.viewModel = viewModel
        self.id = recipeID
    }
    
    func start() {
        viewModel.isLoading = true
        Task {
            do {
                let recipeInfo: RecipeDTO = try await requestManager.perform(RecipeRequest.recipeBy(id: id))
                let instructions: [RecipeInstructionDTO] = try await requestManager.perform(RecipeRequest.instructionsForRecipe(id: id))
                viewModel.recipeInfo = recipeInfo.toDomainRecipe()
                viewModel.instructions = instructions.first?.toDomainInstruction()
                viewModel.isLoading = false
            } catch {
                print(error)
            }
        }
    }
}

