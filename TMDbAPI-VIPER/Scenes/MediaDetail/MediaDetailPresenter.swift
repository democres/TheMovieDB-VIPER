//
//  MediaDetailPresenter.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import Foundation
import UIKit

class MediaDetailPresenter {

    weak private var view: MediaDetailViewProtocol?
    private let media: Media

    init(view: MediaDetailViewProtocol, media: Media) {
        self.view = view
        self.media = media
    }
    
}

extension MediaDetailPresenter: MediaDetailPresenterProtocol {
    func load() {
        view?.update(presentation: media)
    }
}

