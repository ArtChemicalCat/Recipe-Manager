//
//  RandomRecipesDTO.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

struct RecipeDTO: Decodable {
    let id: Int
    let title: String
    let image: URL
    let servings: Int
    let readyInMinutes: Int
    let extendedIngredients: [IngredientDTO]
    let nutrition: NutrientsContainer
    
    func toDomainRecipe() -> Recipe {
        return Recipe(id: id,
                      title: title,
                      imageURL: image,
                      servings: servings,
                      readyInMinutes: readyInMinutes,
                      ingredients: extendedIngredients.map { $0.toDomainIngredient() },
                      nutrients: nutrition.nutrients.map { $0.toDomainNutrient() })
    }
    
    func toDomainRecipeShort() -> RecipeShort {
        return RecipeShort(id: id, title: title, imageURL: image)
    }
}
