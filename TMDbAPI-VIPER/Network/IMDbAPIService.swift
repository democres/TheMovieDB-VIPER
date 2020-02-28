//
//  IMDbAPIService.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Moya

enum TMDbAPIService {
    case searchMovies(title: String, type: String?, year: String?)
    case searchSeries(title: String, type: String?, year: String?)
    case allMoviesRequest
    case allTopRated
    case allUpcoming
    case getMovieDetails(id: Int)
}

extension TMDbAPIService: TargetType {
    
    var API_KEY: String {
        return "b9789908d0c93be753492f01b3b22c23"
    }
    
    var baseURL: URL {
        switch self {
        case .searchMovies:
            return URL(string: "https://api.themoviedb.org/3/search/movie")!
        case .searchSeries:
            return URL(string: "https://api.themoviedb.org/3/search/tv")!
        case .allMoviesRequest:
            return URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc")!
        case .allTopRated:
            return URL(string: "https://api.themoviedb.org/3/movie/top_rated")!
        case .allUpcoming:
            return URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
        case .getMovieDetails(let id):
            return URL(string: "http://api.themoviedb.org/3/movie/\(id)/videos")!
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Method {
        switch self {
        case .searchMovies:
            return .get
        case .searchSeries:
            return .get
        case .allMoviesRequest:
            return .get
        case .getMovieDetails:
            return .get
        case .allTopRated:
            return .get
        case .allUpcoming:
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
        case .searchMovies(let title, let type, let year):
            
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            parameters["query"] = title
            
            if let type = type{
                parameters["type"] = type
            }

            if let year = year {
                parameters["primary_release_year"] = year
            }
            
            return parameters
            
        case .searchSeries(let title, let type, let year):
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            parameters["query"] = title
            
            if let type = type{
                parameters["type"] = type
            }

            if let year = year {
                parameters["first_air_date_year"] = year
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
        case .allTopRated:
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            return parameters
        case .allUpcoming:
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            return parameters
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
