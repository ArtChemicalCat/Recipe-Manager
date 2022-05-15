//
//  AutocompletionTableViewCell.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import UIKit
import Kingfisher

final class RandomRecipeTableViewCell: UITableViewCell {
    //MARK: - Views
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        
        return view
    }()
    
    private let recipeImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Properties
    var recipe: RecipeShort? {
        didSet {
            guard let recipe = recipe else {
                return
            }
            titleLabel.text = recipe.title
            recipeImage.kf.indicatorType = .activity
            recipeImage.kf.setImage(with: recipe.imageURL)
        }
    }
    static var id: String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [recipeImage, titleLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            recipeImage.widthAnchor.constraint(equalTo: recipeImage.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 6),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            bottomAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 6)
        ])
    }
    
}
