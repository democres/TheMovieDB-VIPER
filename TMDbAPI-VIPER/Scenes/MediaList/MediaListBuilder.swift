//
//  MediaListBuilder.swift
//  IMDbAPI-VIPER
//
//  Created David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

class MediaListBuilder {
    static func make(media: [Media]) -> MediaListViewController {
        let storyBoard = UIStoryboard(name: "MediaList", bundle: nil)
        let view: MediaListViewController = storyBoard.instantiateViewController(withIdentifier: "MediaListViewController") as! MediaListViewController
        let presenter = MediaListPresenter(view: view, media: media)
        
        view.presenter = presenter
        
        return view
    }
}
