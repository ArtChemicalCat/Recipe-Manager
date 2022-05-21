//
//  RecipeSearchRootView.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import Combine
import UIKit

final class RecipeSearchRootView: NiblessView {
    //MARK: - Views
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.dataSource = self
        view.rowHeight = 150
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(RandomRecipeTableViewCell.self, forCellReuseIdentifier: RandomRecipeTableViewCell.id)
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Start typing..."
        view.delegate = self
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    private lazy var filtersView: SearchFiltersView = {
        let view = SearchFiltersView(frame: .zero, viewModel: viewModel)
        view.delegate = self
        return view
    }()
    
    //MARK: - Properties
    private let viewModel: RecipeSearchViewModel
    private var subscriptions = Set<AnyCancellable>()
    private var isFiltersHide = true
    
    private lazy var filtersViewTopConstraint = filtersView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -500)
    
    //MARK: - Initialisers
    init(frame: CGRect, viewModel: RecipeSearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        layout()
        observeViewModel()
        configureKeyboardDismissGesture()
    }
    
    //MARK: - Metods
    func showOrHideFilters() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9) { [unowned self] in
            isFiltersHide.toggle()
            filtersView.alpha = isFiltersHide ? 0 : 1
            filtersViewTopConstraint.constant = isFiltersHide ? -500 : 8
            layoutIfNeeded()
        }
    }
        
    //MARK: - Private
    private func observeViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [unowned self] isLoading in
                if isLoading {
                    viewModel.recipe.removeAll()
                    self.loadingIndicator.isHidden = false
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$recipe
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [unowned self] _ in
                self.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
    }
    
    private func layout() {
        [tableView, searchBar, loadingIndicator, filtersView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 6),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            filtersView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            filtersView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            filtersViewTopConstraint
        ])
    }
    
    private func configureKeyboardDismissGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    //MARK: - Actions
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
}
//MARK: - UITableViewDataSource
extension RecipeSearchRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RandomRecipeTableViewCell.id, for: indexPath) as! RandomRecipeTableViewCell
        cell.recipe = viewModel.recipe[indexPath.row]
        
        return cell
    }
    
}
//MARK: - UISearchBarDelegate
extension RecipeSearchRootView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.searchQuery = searchText
        viewModel.search()
        searchBar.resignFirstResponder()
    }
}

extension RecipeSearchRootView: SearchFiltersViewDelegate {
    func applyButtonDidTapped() {
        showOrHideFilters()
    }
}
