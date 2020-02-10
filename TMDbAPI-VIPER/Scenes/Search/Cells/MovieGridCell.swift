//
//  MovieGridCell.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

class MovieGridCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 7
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 7
    }
    
}
