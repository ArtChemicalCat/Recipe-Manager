//
//  RecipeSearchViewController.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 10.05.2022.
//

import UIKit
import Combine

class RecipeSearchViewController: NiblessViewController {
    //MARK: - Properties
    private let recipeDetailViewControllerFactory: RecipeDetailViewControllerFactory
    private let viewModel: RecipeSearchViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    var rootView: RecipeSearchRootView {
        view as! RecipeSearchRootView
    }
    
    init(viewModel: RecipeSearchViewModel, recipeDetailViewControllerFactory: RecipeDetailViewControllerFactory) {
        self.viewModel = viewModel
        self.recipeDetailViewControllerFactory = recipeDetailViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessage()
        title = "Search"
//        viewModel.fetchRandomRecipe()
        view.backgroundColor = .systemBackground
        rootView.tableView.delegate = self
}
    
    override func loadView() {
        view = RecipeSearchRootView(frame: UIScreen.main.bounds, viewModel: viewModel)
    }
    
    private func observeErrorMessage() {
        viewModel.$errorMessageToPresent
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] errorMessage in
                guard let message = errorMessage ,
                      !message.isEmpty else { return }
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                    self?.viewModel.errorMessageToPresent = nil
                }
                alert.addAction(action)
                self?.present(alert, animated: true)
            }
            .store(in: &subscriptions)
    }
}
//MARK: - UITableViewDelegate
extension RecipeSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.recipe[indexPath.row]
        let recipeDetailVC = recipeDetailViewControllerFactory.makeRecipeDetailViewController(for: recipe)
        recipeDetailVC.title = recipe.title
        assert(navigationController != nil)
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}
