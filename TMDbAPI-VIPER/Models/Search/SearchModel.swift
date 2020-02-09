//
//  SearchModel.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 27.01.2020.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import Foundation

struct SearchModel {
    let search: [Media]
}

extension SearchModel: Decodable {
    enum SearchModelCodingKeys: String, CodingKey {
        case search = "Search"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: SearchModelCodingKeys.self)
        
        search = try container.decode([Media].self, forKey: .search)
    }
}
