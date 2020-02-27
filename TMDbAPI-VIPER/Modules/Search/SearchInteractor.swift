//
//  SearchInteractor.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift
import RealmSwift

class SearchInteractor: SearchInteractorProtocol {
    
    weak var delegate: SearchInteractorDelegate?
    
    let moyaProvider = MoyaProvider<TMDbAPIService>(plugins: [NetworkLoggerPlugin()])
    
    func getYearsData() {
        var years: [String] = []
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        for year in 1900 ... currentYear {
            years.insert(String(year), at: 0)
        }
        
        self.delegate?.handleOutput(.showYears(years))
    }
    
    func getTypesData() {
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
    
    func loadMovies() -> Observable<[Media]>{
        delegate?.handleOutput(.setLoading(true))

        return moyaProvider.rx.request(.allMoviesRequest)
                    .debug()
                    .filterSuccessfulStatusCodes()
                    .asObservable()
                    .map{ response -> [Media] in
                        // CUSTOM OBJECT MAPPING DUE TO MOYA DIFFICULTIES TO PARSE THE JSON RESPONSE FROM THE "The Movie Database" SERVER
                        let dataAux = try JSONSerialization.jsonObject(with: response.data, options: [])
                        if let json = dataAux as? [String: Any] {
                            if let results = json["results"] as? [[String: Any]] {
                                if let mediaArray = Mapper<Media>().mapArray(JSONObject: results){
                                    self.storeData(mediaArray: mediaArray)
                                    return mediaArray
                                }
                            }
                        }
                        
                        //RETURN LOCAL REALM CACHE IF EXISTS
                        return self.fetchLocalData()
                        
                    }
    }
    
    func fetchLocalData() -> [Media] {
        var mediaArray = [Media]()
        let realm = try! Realm()
        realm.objects(Media.self).forEach { media in
            mediaArray.append(media)
        }
        return mediaArray
    }
    
    func storeData(mediaArray: [Media]){
        let realm = try! Realm()
        try! realm.write {
            mediaArray.forEach { media in
                realm.add(media)
            }
        }
    }
    

}
    

