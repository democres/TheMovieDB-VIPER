//
//  Media.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper

struct Media: Mappable {
    
    var title: String?
    var poster: String?
    var overview: String?
    
    //MARK: - Mappable
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        poster <- map["poster_path"]
        overview <- map["overview"]
    }
    
}
