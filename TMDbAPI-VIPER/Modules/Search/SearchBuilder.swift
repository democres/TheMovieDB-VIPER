//
//  SearchBuilder.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

final class SearchBuilder {
    static func make(categories: Categories) -> SearchViewController {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let router = SearchRouter(view: view)
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: view,
                                        interactor: interactor,
                                        router: router,
                                        category: categories)
        view.presenter = presenter
        return view
    }
}
