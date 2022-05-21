//
//  RecipeRequest.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 14.05.2022.
//

import Foundation

enum RecipeRequest: RequestProtocol {
    case searchBy(query: String, cuisine: Cuisine = .none, diet: Diet = .none)
    case randomRecipes
    case recipeBy(id: Int)
    case instructionsForRecipe(id: Int)
    
    var path: String {
        switch self {
        case .searchBy:
            return "/recipes/complexSearch"
        case .randomRecipes:
            return "/recipes/random"
        case .recipeBy(let id):
            return "/recipes/\(id)/information"
        case .instructionsForRecipe(let id):
            return "/recipes/\(id)/analyzedInstructions"
        }
    }
    
    var queryItems: [String : String?] {
        var items = ["apiKey": SpoonacularAPIConstants.apiKey]
        switch self {
        case let .searchBy(query, cuisine, diet):
            if !query.isEmpty {
                items["query"] = query
            }
            
            if cuisine != .none {
                items["cuisine"] = cuisine.rawValue
            }
            
            if diet != .none {
                items["diet"] = diet.rawValue
            }
            
            items["number"] = "15"
            return items
        case .randomRecipes:
            items["number"] = "10"
            return items
        case .recipeBy:
            items["includeNutrition"] = "true"
            return items
        case .instructionsForRecipe:
            return items
        }
    }
    var requestType: RequestType {
        .GET
    }
}
