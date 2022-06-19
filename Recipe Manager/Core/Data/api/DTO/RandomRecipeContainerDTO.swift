//
//  RandomRecipeContainerDTO.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

struct RandomRecipeContainerDTO: Decodable {
    let recipes: [RecipeShortDTO]
}
