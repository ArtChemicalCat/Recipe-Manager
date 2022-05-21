//
//  SearchFiltersView.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 18.05.2022.
//

import Foundation
import UIKit

protocol SearchFiltersViewDelegate: AnyObject {
    func applyButtonDidTapped()
}

final class SearchFiltersView: NiblessView {
    private lazy var buttonStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.addArrangedSubview(cuisineButton)
        view.addArrangedSubview(dietButton)
        view.distribution = .fillEqually
        view.spacing = 30
        return view
    }()
    
    private lazy var cuisineButton: UIButton = {
        let button = UIButton()
        var config: UIButton.Configuration = .plain()
        config.title = "Cuisine"
        button.configuration = config
        
        
        return button
    }()
    
    private let dietButton: UIButton = {
        let button = UIButton()
        var config: UIButton.Configuration = .plain()
        config.title = "Diet"
        button.configuration = config
        return button
    }()
    
    private lazy var labelStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .equalCentering
        
        [UIView(), cuisineLabel, UIView(), dietLabel, UIView()].forEach {
            view.addArrangedSubview($0)
        }
        
        return view
    }()
    
    private let cuisineLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .footnote)
        view.text = "-None-"
        return view
    }()
    
    private let dietLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .footnote)
        view.text = "-None-"
        return view
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config: UIButton.Configuration = .bordered()
        config.baseForegroundColor = .systemRed
        config.title = "Clear"
        button.addTarget(self, action: #selector(clearFilters), for: .touchUpInside)
        button.configuration = config
        return button
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config: UIButton.Configuration = .bordered()
        config.title = "Apply"
        button.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        button.configuration = config
        return button
    }()
    
    //MARK: - Properties
    weak var delegate: SearchFiltersViewDelegate?
    
    private let viewModel: RecipeSearchViewModel
    private var cuisineType: Cuisine = .none {
        didSet {
            cuisineLabel.text = "-\(cuisineType.rawValue)-"
            viewModel.cuisineType = cuisineType
        }
    }
    private var dietType: Diet = .none {
        didSet {
            dietLabel.text = "-\(dietType.rawValue)-"
            viewModel.dietType = dietType
        }
    }
    
    //MARK: - Initialiser
    init(frame: CGRect, viewModel: RecipeSearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .systemGray6
        layout()
        setupChooseCuisineButton()
        setupChooseDietButton()
    }
    
    //MARK: - Private Methods
    private func setupChooseCuisineButton() {
        
        let cuisineItems = Cuisine.allCases.map { cuisine in
            UIAction(title: cuisine.rawValue) { [unowned self] _ in
                cuisineType = cuisine
            }
        }
        let menu = UIMenu(title: "", children: cuisineItems)
        cuisineButton.showsMenuAsPrimaryAction = true
        cuisineButton.menu = menu
    }
    
    private func setupChooseDietButton() {
        
        let cuisineItems = Diet.allCases.map { diet in
            UIAction(title: diet.rawValue) { [unowned self] _ in
                dietType = diet
            }
        }
        let menu = UIMenu(title: "", children: cuisineItems)
        dietButton.showsMenuAsPrimaryAction = true
        dietButton.menu = menu
    }
    
    
    private func layout() {
        [buttonStack, clearButton, applyButton, labelStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            labelStack.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 12),
            labelStack.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor),
            
            clearButton.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 16),
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 100),
            
            applyButton.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 12),
            applyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            applyButton.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            
            bottomAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 16)
        ])
    }
    
    //MARK: - Actions
    @objc private func clearFilters() {
        cuisineType = .none
        dietType = .none
    }
    
    @objc private func applyFilters() {
        viewModel.search()
        delegate?.applyButtonDidTapped()
    }
}
