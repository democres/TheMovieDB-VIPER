//
//  MainViewController.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let searchVCPopular = SearchBuilder.make(categories: .popular)
        let searchVCTopRated = SearchBuilder.make(categories: .topRated)
        let searchVCUpcoming = SearchBuilder.make(categories: .upcoming)
        
        self.setViewControllers([searchVCPopular,searchVCTopRated,searchVCUpcoming], animated: false)
        self.selectedIndex = 0

    }
    
}
