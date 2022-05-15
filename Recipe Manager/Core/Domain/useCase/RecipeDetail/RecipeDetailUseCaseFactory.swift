//
//  RecipeDetailUseCaseFactory.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation


protocol RecipeDetailUseCaseFactory {
    func makeGetRecipeInstructionsUseCase(forRecipe id: Int, viewModel: RecipeDetailViewModel) -> UseCase
    func makeRecipeInfoUseCase(id: Int, viewModel: RecipeDetailViewModel) -> UseCase
}
