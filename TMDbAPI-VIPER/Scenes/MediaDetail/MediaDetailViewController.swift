//
//  MediaDetailViewController.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import Foundation
import UIKit

class MediaDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    // MARK: - Properties
    
    var presenter: MediaDetailPresenter!
    var media: Media!


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
        titleLbl.text = self.media.title
    }
    
    
    // MARK: - Handle Presenter Output
    
    
    // MARK: - Helpers
    

    // MARK: - Actions
    
}


extension MediaDetailViewController: MediaDetailViewProtocol {
    func update(presentation media: Media) {
        self.media = media
    }
}
