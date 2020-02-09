//
//  SearchInteractor.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class SearchInteractor: SearchInteractorProtocol {
    
    weak var delegate: SearchInteractorDelegate?
    
    func getYearDatas() {
        var years: [String] = []
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        for year in 1900 ... currentYear {
            years.insert(String(year), at: 0)
        }
        
        self.delegate?.handleOutput(.showYears(years))
    }
    
    func getTypeDatas() {
        let types: [String] = [
            "Movies",
            "Series",
            "Episode"
        ]
        
        self.delegate?.handleOutput(.showTypes(types))
    }
    
    func load(title: String, type: String?, year: String?) {
        delegate?.handleOutput(.setLoading(true))
        
        let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let provider = MoyaProvider<TMDbAPIService>(plugins: pluginsArray)
        
        provider.request(.search(title: title, type: type, year: year)) { [weak self] response in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            
            switch response {
            case .success(let value):
                let data = value.data
                
                do {
                    
                    let dataAux = try JSONSerialization.jsonObject(with: data, options: [])
                    if let json = dataAux as? [String: Any] {
                        print(json)
                        if let results = json["results"] as? [[String: Any]] {
                            if let mediaArray = Mapper<Media>().mapArray(JSONObject: results){
                                print(mediaArray[0].title)
                                self.delegate?.handleOutput(.getMediaList(mediaArray))
                            }
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
    
    
    func loadMovies() {
        delegate?.handleOutput(.setLoading(true))
        
        let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let provider = MoyaProvider<TMDbAPIService>(plugins: pluginsArray)
        
        provider.request(.allMoviesRequest) { [weak self] response in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            
            switch response {
            case .success(let value):
                let data = value.data
                
                do {
                    let dataAux = try JSONSerialization.jsonObject(with: data, options: [])
                    if let json = dataAux as? [String: Any] {
                        print(json)
                        if let results = json["results"] as? [[String: Any]] {
                            if let mediaArray = Mapper<Media>().mapArray(JSONObject: results){
                                print(mediaArray[0].title)
                                self.delegate?.handleOutput(.allMovies(mediaArray))
                            }
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
