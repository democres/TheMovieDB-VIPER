//
//  IMDbAPIService.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Moya

enum TMDbAPIService {
    case search(title: String, type: String?, year: String?)
    case allMoviesRequest
}

extension TMDbAPIService: TargetType {
    var baseURL: URL {
        switch self {
        case .search:
            return URL(string: "https://api.themoviedb.org/3/search/movie")!
        case .allMoviesRequest:
            return URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc")!
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
            parameters["api_key"] = "b9789908d0c93be753492f01b3b22c23"
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
            parameters["api_key"] = "b9789908d0c93be753492f01b3b22c23"

            return parameters
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
