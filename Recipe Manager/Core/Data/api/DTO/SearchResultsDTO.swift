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

