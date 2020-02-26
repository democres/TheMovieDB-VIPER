//
//  Media.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

//struct Media: Mappable,Decodable {
class Media: Object, Mappable {

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var poster: String?
    @objc dynamic var overview: String?
    @objc dynamic var mediaType: String?
    @objc dynamic var trailer: String?
    
    
    //MARK: - Mappable
    required convenience init?(map: Map) {
          self.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        poster <- map["poster_path"]
        overview <- map["overview"]
        mediaType <- map["media_type"]
        trailer <- map["key"]
        id <- map["id"]
    }
    
}
