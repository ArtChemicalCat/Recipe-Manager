//
//  DomainRecipe.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 14.05.2022.
//

import Foundation

struct Recipe {
    let id: Int
    let title: String
    let imageURL: URL
    let servings: Int
    let readyInMinutes: Int
    let ingredients: [Ingredient]
}

struct RecipeShort: Decodable, Equatable {
    let id: Int
    let title: String
    let imageURL: URL
}

