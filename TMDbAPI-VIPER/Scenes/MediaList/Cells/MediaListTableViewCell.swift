//
//  MediaListTableViewCell.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit
import Kingfisher

class MediaListTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func setView(title: String, type: String, imageURL: String) {
        titleLabel.text = title
        typeLabel.text = type
        mediaImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + imageURL))
    }
}
