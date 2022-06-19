//
//  NutritionItemCell.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 17.05.2022.
//

import UIKit

final class NutritionItemCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    private let amountLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    private let dailyNeedsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let dailyNeedsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let dailyNeedsLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .footnote)
        return view
    }()
    
    //MARK: - Properties
    private lazy var dailyNeedsTrailingConstraint = dailyNeedsView.trailingAnchor.constraint(equalTo: trailingAnchor)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with nutrient: Nutrient) {
        nameLabel.text = nutrient.name
        amountLabel.text = "\(nutrient.amount) \(nutrient.unit)"
        dailyNeedsLabel.text = "Percentage of daily needs: \(nutrient.percentOfDailyNeeds)%"
        
        let width = UIScreen.main.bounds.width - 24
        let constant = nutrient.percentOfDailyNeeds < 100 ? (width - width * nutrient.percentOfDailyNeeds / 100 + 12) : 12
        dailyNeedsTrailingConstraint.constant = -constant
    }
    
    private func layout() {
        [dailyNeedsBackgroundView, dailyNeedsView, nameLabel, amountLabel, dailyNeedsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            amountLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            dailyNeedsLabel.centerYAnchor.constraint(equalTo: dailyNeedsView.centerYAnchor),
            dailyNeedsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dailyNeedsView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            dailyNeedsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dailyNeedsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            dailyNeedsBackgroundView.topAnchor.constraint(equalTo: dailyNeedsView.topAnchor),
            dailyNeedsBackgroundView.leadingAnchor.constraint(equalTo: dailyNeedsView.leadingAnchor),
            dailyNeedsBackgroundView.bottomAnchor.constraint(equalTo: dailyNeedsView.bottomAnchor),
            dailyNeedsBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            dailyNeedsTrailingConstraint,
            
        ])
    }
}
