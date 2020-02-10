//
//  MediaListContracts.swift
//  IMDbAPI-VIPER
//
//  Created David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation

// MARK: View
protocol MediaListViewProtocol: class {
    func update(presentation: [Media])
}

// MARK: Interactor


// MARK: Presenter
protocol MediaListPresenterProtocol: class {
    func load()
}


// MARK: - Router
protocol MediaListRouterProtocol: class {
    func navigate(to route: MediaListRoute)
}

enum MediaListRoute {
    case show(Media)
}

