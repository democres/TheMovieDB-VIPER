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
}

// MARK: Presenter
protocol MediaDetailPresenterProtocol: class {
    func load()
}
