//
//  AppDependencyContainer.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation

class AppDependencyContainer {
    private lazy var recipeSearchViewModel = makeRecipeSearchViewModel()
    
    func makeRecipeSearchViewController() -> RecipeSearchViewController {
        RecipeSearchViewController(viewModel: recipeSearchViewModel, recipeDetailViewControllerFactory: self)
    }
    
    func makeRecipeSearchViewModel() -> RecipeSearchViewModel {
        RecipeSearchViewModel(useCaseFactory: self)
    }
}

extension AppDependencyContainer: RecipeSearchUseCaseFactory {
    func makeGetRandomRecipeUseCase() -> UseCase {
        GetRandomRecipeUseCase(viewModel: recipeSearchViewModel)
    }
    
    func makeSearchRecipeUseCase() -> UseCase {
        SearchRecipeUseCase(viewModel: recipeSearchViewModel)
    }

}

extension AppDependencyContainer: RecipeDetailUseCaseFactory {
    
    func makeGetRecipeInstructionsUseCase(forRecipe id: Int, viewModel: RecipeDetailViewModel) -> UseCase {
        RecipeInstructionsUseCase(viewModel: viewModel,
                                  recipeID: id)
    }
    
    func makeRecipeInfoUseCase(id: Int, viewModel: RecipeDetailViewModel) -> UseCase {
        RecipeInfoUseCase(viewModel: viewModel,
                          recipeID: id)
    }
}

extension AppDependencyContainer: RecipeDetailViewControllerFactory {
    func makeRecipeDetailViewController(for recipe: RecipeShort) -> RecipeDetailViewController {
        let viewModel = RecipeDetailViewModel(recipe: recipe,
                                              recipeDetailUseCaseFactory: self)
        return RecipeDetailViewController(viewModel: viewModel)
    }
}

