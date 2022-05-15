//
//  IngredientDTO.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

struct IngredientDTO: Decodable {
    let id: Int
    let name: String
    let original: String
    let amount: Double
    let unit: String
    
    func toDomainIngredient() -> Ingredient {
        return Ingredient(name: name, descriptions: original, amount: amount, unit: unit)
    }
}
