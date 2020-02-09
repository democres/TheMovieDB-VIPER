//
//  RoundedView.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configureView() {
        self.layer.cornerRadius = 10
    }
    
}
