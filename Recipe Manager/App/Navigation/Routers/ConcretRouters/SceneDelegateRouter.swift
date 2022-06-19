//
//  SceneDelegateRouter.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 09.06.2022.
//

import UIKit

final class SceneDelegateRouter: Router {
    //MARK: - Instance Properties
    public let window: UIWindow
    
    //MARK: - Initialisers
    public init(window: UIWindow) {
        self.window = window
    }
    //MARK: - Router
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func dismiss(animated: Bool) {}
    
    
}
