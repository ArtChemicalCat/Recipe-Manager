//
//  NutritionInfoRootView.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 17.05.2022.
//

import Foundation
import UIKit

final class NutritionInfoRootView: NiblessView {
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 75
        view.register(NutritionItemCell.self, forCellReuseIdentifier: NutritionItemCell.id)
        return view
    }()
    
    private let viewModel: NutritionInfoViewModel
    
    init(frame: CGRect = .zero, viewModel: NutritionInfoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        layout()
        backgroundColor = .systemBackground
    }
    
    private func layout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension NutritionInfoRootView: UITableViewDelegate {
    
}

extension NutritionInfoRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nutrients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NutritionItemCell.id, for: indexPath) as! NutritionItemCell
        cell.configure(with: viewModel.nutrients[indexPath.row])
        return cell
    }
    
    
}
