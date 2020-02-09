//
//  AppRouter.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func launchMainView(){
        let viewController = MainViewPresenter.make()
        let navigationController = BaseNavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showSearchViewController() {
        let viewController = SearchBuilder.make()
        let navigationController = BaseNavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
