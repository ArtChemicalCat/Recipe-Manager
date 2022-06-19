//
//  NutritionInfoViewController.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 17.05.2022.
//

import Foundation

final class NutritionInfoViewController: NiblessViewController {
    
    private let viewModel: NutritionInfoViewModel
    
    init(viewModel: NutritionInfoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = NutritionInfoRootView(viewModel: viewModel)
    }
}
