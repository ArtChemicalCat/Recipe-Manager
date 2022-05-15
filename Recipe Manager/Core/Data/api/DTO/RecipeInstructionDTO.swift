//
//  RecipeInstructionDTO.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

struct RecipeInstructionDTO: Decodable {
    let name: String
    let steps: [StepDTO]
    
    func toDomainInstruction() -> Instructions {
        Instructions(steps: steps.map { $0.step })
    }
}

struct StepDTO: Decodable {
    let step: String
}
