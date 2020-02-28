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
    func handlePresenterOutput(_ output: SearchPresenterOutput)
}

enum Categories {
    case popular
    case topRated
    case upcoming

    var title : String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
    
    var image: UIImage {
           switch self {
               case .popular: return UIImage(named: "popular")!
               case .topRated: return UIImage(named: "topRated")!
               case .upcoming: return UIImage(named: "upcoming")!
           }
       }

}

// MARK: - Interactor

protocol SearchInteractorProtocol: class {
    var interactorOutputDelegate: SearchInteractorDelegate? { get set }
    func search(title: String, type: String?, year: String?) -> Observable<[Media]>
    func loadMovies(category: Categories) -> Observable<[Media]>
    func getYearsData()
    func getTypesData()
    func fetchLocalData() -> [Media]
}

protocol SearchInteractorDelegate: class {
    func handleInteractorOutput(_ output: SearchInteractorOutput)
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
    func search(title: String, type: String?, year: String?)
    func loadMovies()
    func getYearsData()
    func getTypesData()
    func validateNameField(name: String?)
    func showMediaList(mediaArray: [Media])
    func showMediaDetail(media: Media)
}

enum SearchPresenterOutput {
    case updateTitle(Categories)
    case setLoading(Bool)
    case searchResults([Media])
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
    case showMediaDetail(Media)
}
