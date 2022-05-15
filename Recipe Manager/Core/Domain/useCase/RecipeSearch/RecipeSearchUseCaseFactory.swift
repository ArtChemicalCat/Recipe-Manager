//
//  RecipeSearchUseCaseFactory.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

protocol RecipeSearchUseCaseFactory {
    func makeGetRandomRecipeUseCase() -> UseCase
    func makeSearchRecipeUseCase(query: String) -> UseCase
}
