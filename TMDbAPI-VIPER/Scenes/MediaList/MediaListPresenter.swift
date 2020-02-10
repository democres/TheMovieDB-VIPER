//
//  MediaListPresenter.swift
//  IMDbAPI-VIPER
//
//  Created David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

class MediaListPresenter {

    weak private var view: MediaListViewProtocol?
    private let mediaArray: [Media]
    private let router: MediaListRouterProtocol
    
    
    init(view: MediaListViewProtocol, mediaArray: [Media],
    router: MediaListRouterProtocol) {
        self.view = view
        self.mediaArray = mediaArray
        self.router = router
    }
    
    func showMediaDetail(media: Media) {
        router.navigate(to: .show(media))
    }
}

extension MediaListPresenter: MediaListPresenterProtocol {
    func load() {
        view?.update(presentation: mediaArray)
    }
}

