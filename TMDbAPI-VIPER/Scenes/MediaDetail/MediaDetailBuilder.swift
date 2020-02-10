//
//  MediaDetailBuilder.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import Foundation
import UIKit

class MediaDetailBuilder {
    static func make(media: Media) -> MediaDetailViewController {
        let storyBoard = UIStoryboard(name: "MediaDetail", bundle: nil)
        let view: MediaDetailViewController = storyBoard.instantiateViewController(withIdentifier: "MediaDetailViewController") as! MediaDetailViewController
        let interactor = MediaDetailInteractor()
        let presenter = MediaDetailPresenter(view: view, media: media, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}
