//
//  RecipeDetailRootView.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 11.05.2022.
//

import UIKit
import Kingfisher
import Combine

final class RecipeDetailRootView: NiblessView {
    //MARK: - Views
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    private let recipeImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let recipeTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    private let servingLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    private let timeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "clock")
        return view
    }()
    
    private let servingImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "fork.knife")
        return view
    }()
    
    private let instructionsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ingredientStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 2
        control.backgroundStyle = .prominent
        control.currentPageIndicatorTintColor = .systemMint
        control.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
        
        return control
    }()
    
    private lazy var scrollViewForPageControl: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    
    //MARK: - Properties
    private let viewModel: RecipeDetailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect, viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        recipeImage.kf.setImage(with: viewModel.recipe.imageURL)
        recipeImage.kf.indicatorType = .activity
        observeViewModel()
        layout()
    }
    
    private func observeViewModel() {
        viewModel.$instructions
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] instructions in
                instructions?.steps.forEach {
                    self.instructionsStack.addArrangedSubview(self.makeLabel(with: $0))
                }
                self.instructionsStack.addArrangedSubview(UIView())
            }
            .store(in: &subscriptions)
        
        viewModel.$recipeInfo
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] recipeInfo in
                self.timeLabel.text = "\(recipeInfo?.readyInMinutes ?? 0) min."
                self.servingLabel.text = "\(recipeInfo?.servings ?? 0) servings"
                recipeInfo?.ingredients.forEach {
                    self.ingredientStack.addArrangedSubview(self.makeLabel(with: $0.descriptions))
                }
                self.ingredientStack.addArrangedSubview(UIView())
            }
            .store(in: &subscriptions)
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [unowned self]  isLoading in
                if isLoading {
                    self.loadingIndicator.isHidden = false
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
    
    override func layoutSubviews() {
        
    }
    
    private func layout() {
        [recipeImage, recipeTitle, timeImage, timeLabel, servingImage, servingLabel, pageControl, scrollViewForPageControl, loadingIndicator]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview($0)
            }
        scrollViewForPageControl.addSubview(ingredientStack)
        scrollViewForPageControl.addSubview(instructionsStack)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            recipeImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            {
                let multiplier = (recipeImage.image?.size.height ?? 1) / (recipeImage.image?.size.width ?? 1)
                return recipeImage.heightAnchor.constraint(equalTo: recipeImage.widthAnchor, multiplier: multiplier)
            }(),
            
            servingImage.leadingAnchor.constraint(equalTo: recipeImage.leadingAnchor, constant: 25),
            servingImage.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            
            servingLabel.leadingAnchor.constraint(equalTo: servingImage.trailingAnchor, constant: 10),
            servingLabel.centerYAnchor.constraint(equalTo: servingImage.centerYAnchor),
            
            timeLabel.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: -25),
            timeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            
            timeImage.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -10),
            timeImage.centerYAnchor.constraint(equalTo: servingImage.centerYAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: servingImage.bottomAnchor, constant: 150),
            
            pageControl.topAnchor.constraint(equalTo: servingImage.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scrollViewForPageControl.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            scrollViewForPageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewForPageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ingredientStack.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            ingredientStack.leadingAnchor.constraint(equalTo: scrollViewForPageControl.leadingAnchor, constant: 24),
            ingredientStack.trailingAnchor.constraint(equalTo: instructionsStack.leadingAnchor, constant: -48),
            ingredientStack.widthAnchor.constraint(equalTo: instructionsStack.widthAnchor),
            ingredientStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            
            instructionsStack.topAnchor.constraint(equalTo: ingredientStack.topAnchor),
            instructionsStack.trailingAnchor.constraint(equalTo: scrollViewForPageControl.trailingAnchor, constant: -24),
            instructionsStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48),
            instructionsStack.heightAnchor.constraint(equalTo: ingredientStack.heightAnchor),
            
            scrollViewForPageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView.bottomAnchor.constraint(equalTo: ingredientStack.bottomAnchor, constant: 16)
        ])
    }
    
    private func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "• \(text)"
        
        return label
    }
    
    @objc private func pageChanged(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        scrollViewForPageControl.setContentOffset(CGPoint(x: CGFloat(currentPage) * frame.size.width, y: 0), animated: true)
    }
}

extension RecipeDetailRootView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollViewForPageControl.contentOffset.x) / Float(scrollViewForPageControl.frame.size.width)))
    }
}
