//
//  SearchModel.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 10/02/20.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation

struct SearchModel {
    let search: [Media]?
}

extension SearchModel: Decodable {
    enum SearchModelCodingKeys: String, CodingKey {
        case search = "Search"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: SearchModelCodingKeys.self)
        search = nil
    }
}

