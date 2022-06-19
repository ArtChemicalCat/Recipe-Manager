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
    private let viewModel: RecipeSearchViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    var rootView: RecipeSearchRootView {
        view as! RecipeSearchRootView
    }
    //MARK: - Initialiser
    init(viewModel: RecipeSearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFilterButton()
        observeErrorMessage()
        title = "Search"
        view.backgroundColor = .systemBackground
        viewModel.fetchRandomRecipe()
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
    
    private func configureFilterButton() {
        let filtersButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(filtersButtonDidTap))
        navigationItem.rightBarButtonItem = filtersButton
    }
    
    @objc private func filtersButtonDidTap() {
        let rootView = view as! RecipeSearchRootView
        rootView.showOrHideFilters()
    }
    
}
//MARK: - UITableViewDelegate
extension RecipeSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.recipe[indexPath.row]
        viewModel.actions.navigateToRecipeDetailView(recipe)
    }
}
