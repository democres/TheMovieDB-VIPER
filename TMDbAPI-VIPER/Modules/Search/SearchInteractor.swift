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
    
    var interactorOutputDelegate: SearchInteractorDelegate?
    
    let moyaProvider = MoyaProvider<TMDbAPIService>(plugins: [NetworkLoggerPlugin()])
    
    func getYearsData() {
        var years: [String] = []
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        for year in 1900 ... currentYear {
            years.insert(String(year), at: 0)
        }
        
        self.interactorOutputDelegate?.handleInteractorOutput(.showYears(years))
    }
    
    func getTypesData() {
        let types: [String] = [
            "Movies",
            "Series",
            "Episode"
        ]
        
        self.interactorOutputDelegate?.handleInteractorOutput(.showTypes(types))
    }
    
    func search(title: String, type: String?, year: String?) -> Observable<[Media]>{
        interactorOutputDelegate?.handleInteractorOutput(.setLoading(true))
        
        let target: TMDbAPIService
        
        if type == "Series" || type == "Episode" {
            target = .searchSeries(title: title, type: type, year: year)
        } else {
            target = .searchMovies(title: title, type: type, year: year)
        }
        
        return moyaProvider.rx.request(target)
                .debug()
                .filterSuccessfulStatusCodes()
                .asObservable()
                .map{ response -> [Media] in
                    let dataAux = try JSONSerialization.jsonObject(with: response.data, options: [])
                    if let json = dataAux as? [String: Any] {
                        if let results = json["results"] as? [[String: Any]] {
                            if let mediaArray = Mapper<Media>().mapArray(JSONObject: results){
                                return mediaArray
                            }
                        }
                    }
                    return [Media]()
                 }
    }
    
    
    func loadMovies(category: Categories) -> Observable<[Media]>{
        interactorOutputDelegate?.handleInteractorOutput(.setLoading(true))

        let target: TMDbAPIService
        switch category {
            case .popular:
                target = .allMoviesRequest
            case .topRated:
                target = .allTopRated
            case .upcoming:
                target = .allUpcoming
        }
        
        return moyaProvider.rx.request(target)
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
        do {
            let realm = try Realm()
            realm.objects(Media.self).forEach { media in
                mediaArray.append(media)
            }
        } catch let error {
            print(error)
        }
        return mediaArray
    }
    
    func storeData(mediaArray: [Media]){
        do {
            let realm = try Realm()
            try realm.write {
                mediaArray.forEach { media in
                    realm.add(media)
                }
            }
        } catch let error {
            print(error)
        }
    }
    

}
    

