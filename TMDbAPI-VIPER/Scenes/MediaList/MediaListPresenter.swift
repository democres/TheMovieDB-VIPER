//
//  MediaListPresenter.swift
//  TMDbAPI-VIPER
//
//  Created Furkan Kurnaz on 23.05.2019.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

class MediaListPresenter {

    weak private var view: MediaListViewProtocol?
    private let media: SearchModel

    init(view: MediaListViewProtocol, media: SearchModel) {
        self.view = view
        self.media = media
    }
}

extension MediaListPresenter: MediaListPresenterProtocol {
    func load() {
        view?.update(presentation: media)
    }
}

