//
//  BaseNavigationController.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationBar.barTintColor = UIColor(hexString: "#081c24")
        navigationBar.tintColor = .black
        navigationBar.alpha = 1
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationBar.titleTextAttributes = textAttributes
    }
    
}

