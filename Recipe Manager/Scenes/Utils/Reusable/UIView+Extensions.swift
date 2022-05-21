//
//  UIView+Extensions.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 17.05.2022.
//

import Foundation
import UIKit

extension UIView {
    static var id: String {
        String(describing: self)
    }
    
    func fillSuperview() {
        guard let parent = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor),
            leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
            bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fillSuperview(padding: CGFloat) {
        guard let parent = superview else { return }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
