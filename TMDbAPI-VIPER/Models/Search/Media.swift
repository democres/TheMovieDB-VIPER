//
//  Media.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import Foundation

struct Media {
    let title: String
    let year: String
    let id: String
    let type: String
    let poster: String
}

extension Media: Decodable {
    enum MediaCodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: MediaCodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        poster = try container.decode(String.self, forKey: .poster)
    }
}

