//
//  RecipeDetailViewController.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Combine
import UIKit

final class RecipeDetailViewController: NiblessViewController {
    //MARK: - Metods
    let viewModel: RecipeDetailViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    private var rootView: RecipeDetailRootView {
        view as! RecipeDetailRootView
    }
    
    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    //MARK: - Lifecycle
    override func loadView() {
        view = RecipeDetailRootView(frame: UIScreen.main.bounds, viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoButton()
        viewModel.getRecipeInfo()
    }
    
    private func configureInfoButton() {
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                         style: .plain, target: self, action: #selector(navigateToNutritionVC))
        
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func navigateToNutritionVC() {
        guard let nutrients = viewModel.recipeInfo?.nutrients else { return }
        
        viewModel.actions.navigateToNutritionInfoView(nutrients)
    }
}
