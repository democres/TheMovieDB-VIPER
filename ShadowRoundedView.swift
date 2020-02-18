//
//  ShadowView.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 18/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
    }
}
