//
//  Media.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper

struct Media: Mappable {
    
    var title: String?
    var poster: String?
    var overview: String?
    var mediaType: String?
    var trailer: String?
    var id: Int?
    
    //MARK: - Mappable
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        poster <- map["poster_path"]
        overview <- map["overview"]
        mediaType <- map["media_type"]
        trailer <- map["key"]
        id <- map["id"]
    }
    
}
