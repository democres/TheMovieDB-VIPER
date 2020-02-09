//
//  IMDbAPIService.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import Moya

enum IMDbAPIService {
    case search(title: String, type: String?, year: String?)
}

extension IMDbAPIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Method {
        switch self {
        case .search:
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
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
