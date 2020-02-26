//
//  SearchContracts.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - View

protocol SearchViewProtocol: class {
    func handleOutput(_ output: SearchPresenterOutput)
}

// MARK: - Interactor

protocol SearchInteractorProtocol: class {
    var delegate: SearchInteractorDelegate? { get set }
    func load(title: String, type: String?, year: String?)
    func loadMovies() -> Observable<[Media]>
    func getYearsData()
    func getTypesData()
    func fetchLocalData() -> [Media]
}

protocol SearchInteractorDelegate: class {
    func handleOutput(_ output: SearchInteractorOutput)
}

enum SearchInteractorOutput {
    case setLoading(Bool)
    case getMediaList([Media])
    case allMovies([Media])
    case showYears([String])
    case showTypes([String])
}

// MARK: - Presenter

protocol SearchPresenterProtocol: class {
    func load(title: String, type: String?, year: String?)
    func loadMovies()
    func getYearsData()
    func getTypesData()
    func validateNameField(name: String?)
    func showMediaList(mediaArray: [Media])
    func showMediaDetail(media: Media)
}

enum SearchPresenterOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case getMediaList([Media])
    case allMovies([Media])
    case showYears([String])
    case showTypes([String])
    case isValidName(Bool)
}

// MARK: - Router

protocol SearchRouterProtocol: class {
    func navigate(to route: SearchRoute)
}

enum SearchRoute {
    case list([Media])
    case showDetail(Media)
}
