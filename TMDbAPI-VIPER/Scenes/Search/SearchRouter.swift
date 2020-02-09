//
//  SearchRouter.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: SearchRoute) {
        switch route {
        case .list(let mediaArray):
            let listView = MediaListBuilder.make(media: mediaArray)
            view.show(listView, sender: nil)
        }
    }
}
