//
//  MovieGridCell.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

class MovieGridCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 7
    }

}
