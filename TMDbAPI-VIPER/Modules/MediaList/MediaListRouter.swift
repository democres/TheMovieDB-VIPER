//
//  MediaListRouter.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import Foundation
import UIKit

final class MediaListRouter: MediaListRouterProtocol {
    func navigate(to route: MediaListRoute) {
        switch route {
        case .show(let media):
            let mediaDetailView = MediaDetailBuilder.make(media: media)
            view.show(mediaDetailView, sender: nil)
        }
    }
    
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
