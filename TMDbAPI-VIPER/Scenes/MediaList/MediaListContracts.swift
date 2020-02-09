//
//  MediaListContracts.swift
//  TMDbAPI-VIPER
//
//  Created Furkan Kurnaz on 23.05.2019.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import Foundation

// MARK: View
protocol MediaListViewProtocol: class {
    func update(presentation: SearchModel)
}

// MARK: Presenter
protocol MediaListPresenterProtocol: class {
    func load()
}
