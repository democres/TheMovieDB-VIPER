//
//  MediaDetailInteractor.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class MediaDetailInteractor: MediaDetailInteractorProtocol {
    
    weak var delegate: MediaDetailInteractorDelegate?
    
    func getMovieDetail(id: Int) {
        
        let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let provider = MoyaProvider<TMDbAPIService>(plugins: pluginsArray)
        
        provider.request(.getMovieDetails(id: id)) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let value):
                let data = value.data
                
                do {
                    
                    let dataAux = try JSONSerialization.jsonObject(with: data, options: [])
                    if let json = dataAux as? [String: Any] {
                        print(json)
                        if let results = json["results"] as? [String: Any] {
                            let trailerKey = results["key"] as? String
                            self.delegate?.handleOutput(.movieDetail(trailerKey ?? ""))
                        }
                    }
                    
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
    
}
