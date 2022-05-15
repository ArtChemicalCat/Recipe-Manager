//
//  SearchResultsDTO.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

struct SearchResultsDTO: Decodable {
    let results: [RecipeShortDTO]
    let totalResults: Int
}

struct RecipeShortDTO: Decodable {
    let id: Int
    let title: String
    let image: URL
    let calories: Int?
    
    func toDomainRecipeShort() -> RecipeShort {
        return RecipeShort(id: id, title: title, imageURL: image)
    }
}
