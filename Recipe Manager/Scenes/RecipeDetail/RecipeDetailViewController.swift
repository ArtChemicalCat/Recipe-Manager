//
//  RecipeDetailViewController.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Foundation
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
        viewModel.getRecipeInfo()
    }
    
}

protocol RecipeDetailViewControllerFactory {
    func makeRecipeDetailViewController(for recipe: RecipeShort) -> RecipeDetailViewController
}
