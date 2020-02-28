//
//  SearchPresenter.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import RxSwift

final class SearchPresenter: SearchPresenterProtocol {
    
    private let category: Categories
    private let view: SearchViewProtocol
    private let interactor: SearchInteractorProtocol
    private let router: SearchRouterProtocol
        
    private let disposeBag = DisposeBag()
    
    init(view: SearchViewProtocol,
         interactor: SearchInteractorProtocol,
         router: SearchRouterProtocol,
         category: Categories) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        self.category = category
        
        self.interactor.interactorOutputDelegate = self
        
        view.handlePresenterOutput(.updateTitle(category))
        
    }
    
    func getYearsData() {
        interactor.getTypesData()
    }
    
    func getTypesData() {
        interactor.getYearsData()
    }
    
    func search(title: String, type: String?, year: String?) {
        interactor.search(title: title, type: type, year: year)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] mediaArray in
                self?.view.handlePresenterOutput(.searchResults(mediaArray))
        }, onError: { (error) in
             print(error)
             // HANDLE THE ERROR
        })
        .disposed(by: disposeBag)
    }
    
    func loadMovies() {
        interactor.loadMovies(category: self.category)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] mediaArray in
                self?.view.handlePresenterOutput(.allMovies(mediaArray))
        }, onError: { (error) in
            print(error)
            // HANDLE THE ERROR
            self.view.handlePresenterOutput(.allMovies(self.interactor.fetchLocalData()))
        })
        .disposed(by: disposeBag)
    }
    
    func validateNameField(name: String?) {
        if let name = name {
            if name.count > 0 {
                view.handlePresenterOutput(.isValidName(true))
            } else {
                view.handlePresenterOutput(.isValidName(false))
            }
        } else {
            view.handlePresenterOutput(.isValidName(false))
        }
    }
    
    func showMediaList(mediaArray: [Media]) {
        router.navigate(to: .list(mediaArray))
    }
    
    func showMediaDetail(media: Media) {
        router.navigate(to: .showMediaDetail(media))
    }
}

extension SearchPresenter: SearchInteractorDelegate {
    func handleInteractorOutput(_ output: SearchInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handlePresenterOutput(.setLoading(isLoading))
        case .allMovies(let movies):
            view.handlePresenterOutput(.allMovies(movies))
        case .getMediaList(let medias):
            view.handlePresenterOutput(.searchResults(medias))
        case .showYears(let years):
            view.handlePresenterOutput(.showYears(years))
        case .showTypes(let types):
            view.handlePresenterOutput(.showTypes(types))
        }
    }
}
