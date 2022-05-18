//
//  NutritionInfoViewModel.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 17.05.2022.
//

import Foundation

final class NutritionInfoViewModel {
    let nutrients: [Nutrient]
    
    init(nutrients: [Nutrient]) {
        self.nutrients = nutrients
    }
}
