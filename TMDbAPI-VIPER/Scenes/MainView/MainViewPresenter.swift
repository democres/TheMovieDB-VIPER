//
//  MainBuilder.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit


final class MainViewPresenter {
    static func make() -> UIViewController {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        return viewController
    }
}
