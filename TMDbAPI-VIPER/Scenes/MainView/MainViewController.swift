//
//  MainViewController.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let searchViewController = SearchBuilder.make()
        
        self.setViewControllers([searchViewController], animated: false)
        self.selectedIndex = 0

    }
    
}
