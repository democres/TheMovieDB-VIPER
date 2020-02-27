//
//  SearchRouter.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
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
            if mediaArray.count == 0 {
                let alert = UIAlertController(title: "Search", message: "No results were found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                view.present(alert, animated: true, completion: nil)
                
                return
            }
            let listView = MediaListBuilder.make(media: mediaArray)
            view.show(listView, sender: nil)
        case .showDetail(let media):
            let mediaDetailView = MediaDetailBuilder.make(media: media)
            view.show(mediaDetailView, sender: nil)
        }
    }
}
