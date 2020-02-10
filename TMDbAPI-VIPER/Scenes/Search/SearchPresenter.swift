//
//  SearchPresenter.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    private let view: SearchViewProtocol
    private let interactor: SearchInteractorProtocol
    private let router: SearchRouterProtocol
    
    init(view: SearchViewProtocol,
         interactor: SearchInteractorProtocol,
         router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
        
        view.handleOutput(.updateTitle("TMDb Search"))
    }
    
    func getYearDatas() {
        interactor.getTypeDatas()
    }
    
    func getTypeDatas() {
        interactor.getYearDatas()
    }
    
    func load(title: String, type: String?, year: String?) {
        interactor.load(title: title, type: type, year: year)
    }
    
    func loadMovies() {
        interactor.loadMovies()
    }
    
    func validateNameField(name: String?) {
        if let name = name {
            if name.count > 0 {
                view.handleOutput(.isValidName(true))
            } else {
                view.handleOutput(.isValidName(false))
            }
        } else {
            view.handleOutput(.isValidName(false))
        }
    }
    
    func showMediaList(mediaArray: [Media]) {
        router.navigate(to: .list(mediaArray))
    }
    
    func showMediaDetail(media: Media) {
        router.navigate(to: .showDetail(media))
    }
}

extension SearchPresenter: SearchInteractorDelegate {
    func handleOutput(_ output: SearchInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .allMovies(let movies):
            view.handleOutput(.allMovies(movies))
        case .getMediaList(let medias):
            view.handleOutput(.getMediaList(medias))
        case .showYears(let years):
            view.handleOutput(.showYears(years))
        case .showTypes(let types):
            view.handleOutput(.showTypes(types))
        }
    }
}
