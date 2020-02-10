//
//  IMDbAPIService.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Moya

enum TMDbAPIService {
    case search(title: String, type: String?, year: String?)
    case allMoviesRequest
    case getMovieDetails(id: Int)
}

extension TMDbAPIService: TargetType {
    
    var API_KEY: String {
        return "b9789908d0c93be753492f01b3b22c23"
    }
    
    var baseURL: URL {
        switch self {
        case .search:
            return URL(string: "https://api.themoviedb.org/3/search/movie")!
        case .allMoviesRequest:
            return URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc")!
        case .getMovieDetails(let id):
            return URL(string: "http://api.themoviedb.org/3/movie/\(id)/videos")!
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Method {
        switch self {
        case .search:
            return .get
        case .allMoviesRequest:
            return .get
        case .getMovieDetails(let id):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var parameters: [String : Any] {
        switch self {
        case .search(let title, let type, let year):
            
            
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            parameters["query"] = title
            
            if let type = type{
                parameters["type"] = type
            }
            
            if let year = year {
                parameters["y"] = year
            }
            
            return parameters
            
        case .allMoviesRequest:
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY

            return parameters
        case .getMovieDetails:
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY

            return parameters
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
