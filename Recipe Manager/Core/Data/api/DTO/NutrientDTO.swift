//
//  Nutrient.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 17.05.2022.
//

import Foundation

struct NutrientsContainer: Decodable {
    let nutrients: [NutrientDTO]
}

struct NutrientDTO: Decodable {
    let name: String
    let amount: Double
    let unit: String
    let percentOfDailyNeeds: Double
    
    func toDomainNutrient() -> Nutrient {
        return Nutrient(name: name, amount: amount, unit: unit, percentOfDailyNeeds: percentOfDailyNeeds)
    }
}
