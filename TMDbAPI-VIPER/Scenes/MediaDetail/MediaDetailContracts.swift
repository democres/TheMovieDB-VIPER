//
//  MediaDetailContracts.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import Foundation

import Foundation

// MARK: View
protocol MediaDetailViewProtocol: class {
    func update(presentation: Media)
    func showMovieTrailer(trailerKey: String)
}

// MARK: Interactor
protocol MediaDetailInteractorProtocol: class {
    var delegate: MediaDetailInteractorDelegate? { get set }
    func getMovieDetail(id: Int)
}

protocol MediaDetailInteractorDelegate: class {
    func handleOutput(_ output: MediaDetailInteractorOutput)
}

enum MediaDetailInteractorOutput {
    case movieDetail(String)
}

// MARK: Presenter
protocol MediaDetailPresenterProtocol: class {
    func load()
    func getMovieDetail(id: Int)
}

enum MediaDetailPresenterOutput {
    case trailerKey(String)
}
