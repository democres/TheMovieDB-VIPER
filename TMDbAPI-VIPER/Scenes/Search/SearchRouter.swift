//
//  SearchRouter.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: SearchRoute) {
        switch route {
        case .list(let searchModel):
            let listView = MediaListBuilder.make(media: searchModel)
            view.show(listView, sender: nil)
        }
    }
}
