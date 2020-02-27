//
//  MediaDetailPresenter.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/02/20.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import Foundation
import UIKit

class MediaDetailPresenter: MediaDetailPresenterProtocol {
    
    weak private var view: MediaDetailViewProtocol?
    private let interactor: MediaDetailInteractorProtocol
    private let media: Media

    init(view: MediaDetailViewProtocol, media: Media, interactor: MediaDetailInteractorProtocol) {
        self.view = view
        self.media = media
        self.interactor = interactor
        
        self.interactor.delegate = self
    }
    
    func load() {
        view?.update(presentation: media)
    }
    
    func getMovieDetail(id: Int) {
        interactor.getMovieDetail(id: id)
//        view?.showMovieTrailer(movieKey: trailerKey)
    }
}

extension MediaDetailPresenter: MediaDetailInteractorDelegate{
    func handleOutput(_ output: MediaDetailInteractorOutput) {
        switch output {
        case .movieDetail(let movieKey):
            view?.showMovieTrailer(trailerKey: movieKey)
        }
    }
    
    
}
