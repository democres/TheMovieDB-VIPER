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
        UITabBar.appearance().barTintColor =  UIColor(hexString: "#081c24")
        UITabBar.appearance().tintColor = .white
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#081c24")
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
    }
    
}

